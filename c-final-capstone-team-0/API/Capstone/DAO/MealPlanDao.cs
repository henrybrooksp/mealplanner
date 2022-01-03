using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Capstone.DAO;

namespace Capstone.DAO
{
    public class MealPlanDao : IMealPlanDao
    {
        private readonly string connectionString;

        public MealPlanDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public MealPlan GetMealPlanById(int mealPlanId)
        {
            MealPlan mealPlan = new MealPlan();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT meal_plan_id, meal_plan_name FROM meal_plan WHERE meal_plan_id = " + mealPlanId + "", conn);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        mealPlan = GetMealPlanFromReader(reader);
                    }
                    reader.Close();
                }
                return mealPlan;
            }
            catch (SqlException)
            {
                throw new Exception();
            }
        }
        public List<SimplifiedRecipe> GetMealPlanRecipes(int mealPlanId)
        {
            List<SimplifiedRecipe> mealPlanRecipes = new List<SimplifiedRecipe>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT recipes.recipe_id, recipe_name  FROM recipes " +
                        "JOIN meal_plan_recipe ON recipes.recipe_id = meal_plan_recipe.recipe_id " +
                        "JOIN meal_plan ON meal_plan_recipe.meal_plan_id = meal_plan.meal_plan_id " +
                        "WHERE meal_plan_recipe.meal_plan_id = "+mealPlanId+"", conn);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while(reader.Read())
                    {
                        SimplifiedRecipe recipe = new SimplifiedRecipe()
                        {
                            RecipeId = Convert.ToInt32(reader["recipe_id"]),
                            RecipeName = Convert.ToString(reader["recipe_name"])
                        };
                        if (recipe != null)
                        {
                            mealPlanRecipes.Add(recipe);
                        }
                    }
                    reader.Close();
                }
                return mealPlanRecipes;
            }
            catch (SqlException)
            {
                throw new Exception();
            }
        }
        public List<MealPlan> GetMealPlanByUser(int userId)
        {
            List<MealPlan> userMealPlans = new List<MealPlan>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT meal_plan.meal_plan_id, meal_plan_name FROM meal_plan JOIN meal_plan_user ON meal_plan.meal_plan_id = meal_plan_user.meal_plan_id WHERE user_id = "+ userId +"", conn);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        MealPlan mealPlan = GetMealPlanFromReader(reader);
                        if (mealPlan != null)
                        {
                            userMealPlans.Add(mealPlan);
                        }
                    }
                    reader.Close();
                }
                return userMealPlans;
            }
            catch(SqlException)
            {
                throw new Exception();
            }
        }
        
        public MealPlan CreateMealPlan(UserMealPlan mealPlan)
        {
            int mealPlanId;
            try
            {
                using(SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO meal_plan (meal_plan_name) VALUES('" + mealPlan.MealPlanName + "'); SELECT @@IDENTITY;", conn);
                    mealPlanId = Convert.ToInt32(cmd.ExecuteScalar());
                    cmd = new SqlCommand("INSERT INTO meal_plan_user (meal_plan_id, user_id) VALUES (" + mealPlanId + ", " + mealPlan.UserId + ")", conn);
                    cmd.ExecuteNonQuery();
                }
                return GetMealPlanById(mealPlanId);
            }
            catch(SqlException)
            {
                throw new Exception("");
            }
        }
        private MealPlan GetMealPlanFromReader(SqlDataReader reader)
        {
            try
            {
                MealPlan mealPlan = new MealPlan()
                {
                    MealPlanId = Convert.ToInt32(reader["meal_plan_id"]),
                    MealPlanName = Convert.ToString(reader["meal_plan_name"]),
                };
                return mealPlan;
            }
            catch (SqlException)
            {
                throw new Exception();
            }
        }
    }
}
