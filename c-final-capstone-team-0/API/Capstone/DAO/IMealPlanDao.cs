using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public interface IMealPlanDao
    {
        public MealPlan GetMealPlanById(int mealPlanId);

        public MealPlan CreateMealPlan(UserMealPlan mealPlan);

        public List<MealPlan> GetMealPlanByUser(int userId);

        public List<SimplifiedRecipe> GetMealPlanRecipes(int mealPlanId);
    }
}
