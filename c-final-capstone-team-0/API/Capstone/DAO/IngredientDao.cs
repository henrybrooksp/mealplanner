using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public class IngredientDao : IIngredientDao
    {
        private readonly string connectionString;

        public IngredientDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }
        public Ingredient GetIngredientById(int ingredientId)
        {
            Ingredient ingredient = new Ingredient();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT ingredient_id, ingredient_name FROM ingredients WHERE ingredient_id = " + ingredientId + "", conn);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        ingredient = GetIngredientFromReader(reader);
                    }
                    reader.Close();
                }
                return ingredient;
            }
            catch (SqlException)
            {
                throw new Exception();
            }
        }
        public Ingredient CreateIngredient(Ingredient ingredient)
        {
            int newIngredientId;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO ingredients(ingredient_name) VALUES('" + ingredient.IngredientName + "'); SELECT @@IDENTITY", conn);
                    newIngredientId = Convert.ToInt32(cmd.ExecuteScalar());
                }
                return GetIngredientById(newIngredientId);
            }
            catch (SqlException)
            {
                throw new Exception("Ingredient may already exist");
            }
        }
        public List<Ingredient> GetAllIngredients()
        {
            List<Ingredient> ingredients = new List<Ingredient>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM ingredients", conn);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Ingredient ingredient = GetIngredientFromReader(reader);
                        if (ingredient != null)
                        {
                            ingredients.Add(ingredient);
                        }
                    }
                    reader.Close();
                }
                return ingredients;
            }
            catch (SqlException)
            {
                throw new Exception();
            }
        }
        public List<RecipeIngredient> GetIngredientsByRecipe(int recipeId)
        {
            List<RecipeIngredient> recipeIngredients = new List<RecipeIngredient>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT ingredients.ingredient_id, ingredient_name, amount, unit FROM ingredients " +
                        "JOIN recipe_ingredients ON ingredients.ingredient_id = recipe_ingredients.ingredient_id " +
                        "JOIN recipes ON recipe_ingredients.recipe_id = recipes.recipe_id " +
                        "WHERE recipes.recipe_id = @recipeId", conn);
                    cmd.Parameters.AddWithValue("@recipeId", recipeId);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        RecipeIngredient ingredient = GetRecipeIngredientFromReader(reader);
                        if(ingredient != null)
                        {
                            recipeIngredients.Add(ingredient);
                        }
                    }
                    reader.Close();
                }
                return recipeIngredients;
            }
            catch (SqlException)
            {
                throw new Exception();
            }
        }
        public List<RecipeIngredient> AddRecipeIngredient(AddedRecipeIngredient ingredient)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO recipe_ingredients(recipe_id, ingredient_id, amount, unit) VALUES(" + ingredient.RecipeId + ", (SELECT ingredient_id FROM ingredients WHERE ingredient_name = '"+ingredient.IngredientName+"'), '"+ingredient.Amount+"', '"+ingredient.Unit+"')", conn);
                    cmd.ExecuteNonQuery();
                }
                return GetIngredientsByRecipe(ingredient.RecipeId);
            }
            catch(SqlException)
            {
                throw new Exception("Could not add ingredient to recipe");
            }
        }
        public List<string> GetUserGroceryList(int userId)
        {
            List<string> groceryList = new List<string>();
            try
            {
                using(SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT ingredient_name FROM ingredients " +
                        "JOIN recipe_ingredients ON ingredients.ingredient_id = recipe_ingredients.ingredient_id " +
                        "JOIN recipes ON recipe_ingredients.recipe_id = recipes.recipe_id " +
                        "JOIN meal_plan_recipe ON recipes.recipe_id = meal_plan_recipe.recipe_id " +
                        "JOIN meal_plan ON meal_plan_recipe.meal_plan_id = meal_plan.meal_plan_id " +
                        "JOIN meal_plan_user ON meal_plan.meal_plan_id = meal_plan_user.meal_plan_id " +
                        "WHERE user_id = " + userId + "", conn);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string ingredient = Convert.ToString(reader["ingredient_name"]);
                        if (ingredient != null && !groceryList.Contains(ingredient))
                        {
                           groceryList.Add(ingredient);
                        }
                    }
                    reader.Close();
                }
                return groceryList;
            }
            catch(SqlException)
            {
                throw new Exception();
            }
        }
        private RecipeIngredient GetRecipeIngredientFromReader(SqlDataReader reader)
        {
            try
            {
                RecipeIngredient ingredient = new RecipeIngredient()
                {
                    //ingredients.ingredient_id may be an issue in the future!!
                    IngredientId = Convert.ToInt32(reader["ingredient_id"]),
                    IngredientName = Convert.ToString(reader["ingredient_name"]),
                    Amount = Convert.ToString(reader["amount"]),
                    Unit = Convert.ToString(reader["unit"]),
                };
                return ingredient;
            }
            catch (SqlException)
            {
                throw new Exception();
            }
        }
        private Ingredient GetIngredientFromReader(SqlDataReader reader)
        {
            try
            {
                Ingredient ingredient = new Ingredient()
                {
                    IngredientId = Convert.ToInt32(reader["ingredient_id"]),
                    IngredientName = Convert.ToString(reader["ingredient_name"]),
                };
                return ingredient;
            }
            catch (SqlException)
            {
                throw new Exception();
            }
        }
    }
}
