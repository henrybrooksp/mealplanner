using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Recipe
    {
        public string RecipeName { get; set; }
        public string Calories { get; set; }
        public string Instructions { get; set; }
        public string Image { get; set; }
        public string Category { get; set; }
        public string DishType { get; set; }
        public int UserId { get; set; }     
    }

    public class MealRecipe
    {
        public int RecipeId { get; set; }
        public string RecipeName { get; set; }
        public string Calories { get; set; }
        public string Instructions { get; set; }
        public string Image { get; set; }
        public string Category { get; set; }
        public string DishType { get; set; }
    }
    public class UserRecipe
    {
        public int UserId { get; set; }
        public int RecipeId { get; set; }
    }
    public class SimplifiedRecipe
    {
        public int RecipeId { get; set; }
        public string RecipeName { get; set; }
    }
    public class AddedMealRecipe
    {
        public int MealPlanId { get; set; }
        public int RecipeId { get; set; }
    }
    public class UpdatedRecipe
    {
        public string RecipeName { get; set; }
        public string Calories { get; set; }
        public string Instructions { get; set; }
        public string Image { get; set; }
        public string Category { get; set; }
        public string DishType { get; set; }
    }
}
