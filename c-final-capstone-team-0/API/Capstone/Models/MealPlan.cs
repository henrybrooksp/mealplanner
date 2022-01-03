using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class MealPlan
    {
        public int MealPlanId { get; set; }
        public string MealPlanName { get; set; }
    }

    public class UserMealPlan
    {
        public int UserId { get; set; }
        public string MealPlanName { get; set; }
    }
}
