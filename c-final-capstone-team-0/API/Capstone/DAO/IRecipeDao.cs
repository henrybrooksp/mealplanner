using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public interface IRecipeDao
    {
        public List<MealRecipe> GetAllRecipes();

        public MealRecipe GetRecipe(int recipeId);

        public List<MealRecipe> GetRecipesByUser(int userId);

        public List<MealRecipe> SearchByIngredient(string ingredient);

        public List<MealRecipe> SearchByCategory(string category);

        public UserRecipe AddUserRecipe(UserRecipe newRecipe);

        public UserRecipe CreateNewRecipe(Recipe newRecipe);

        public MealRecipe AddRecipeToMealPlan(AddedMealRecipe mealRecipe);
        
        public bool DeleteRecipeFromMealPlan(AddedMealRecipe delete);

        public MealRecipe UpdateRecipe(MealRecipe updatedRecipe);
    }
}
