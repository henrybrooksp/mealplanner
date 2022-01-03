using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Ingredient
    {
        public int? IngredientId { get; set; }
        public string IngredientName { get; set; }
    }
    public class RecipeIngredient
    {
        public int IngredientId { get; set; }
        public string IngredientName { get; set; }
        public string Amount { get; set; }
        public string Unit { get; set; }
    }
    public class AddedRecipeIngredient
    {
        public int RecipeId { get; set; }
        public string IngredientName { get; set; }
        public string Amount { get; set; }
        public string Unit { get; set; }
    }
}
