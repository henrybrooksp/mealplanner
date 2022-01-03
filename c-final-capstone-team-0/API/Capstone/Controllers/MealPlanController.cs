using Capstone.DAO;
using Capstone.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Controllers
{
    [Route("mealplan/")]
    [ApiController]
    [Authorize]
    public class MealPlanController : ControllerBase
    {
        private readonly IMealPlanDao mealPlanDao;

        public MealPlanController(IMealPlanDao _mealPlanDao)
        {
            mealPlanDao = _mealPlanDao;
        }
        [HttpPost("create")]
        public ActionResult<MealPlan> CreateMealPlan(UserMealPlan mealPlan)
        {
            MealPlan added = mealPlanDao.CreateMealPlan(mealPlan);
            return Created($"mealplan/create/{added.MealPlanId}", added);
        }
        [HttpGet("user/{userId}")]
        public ActionResult<List<MealPlan>> GetMealPlanByUser(int userId)
        {
            List<MealPlan> userMealPlans = mealPlanDao.GetMealPlanByUser(userId);
            if(userMealPlans != null)
            {
                return Ok(userMealPlans);
            }
            return StatusCode(404);
        }
        [HttpGet("recipes/{mealPlanId}")]
        public ActionResult<List<SimplifiedRecipe>> GetMealPlanRecipes(int mealPlanId)
        {
            List<SimplifiedRecipe> mealPlanRecipes = mealPlanDao.GetMealPlanRecipes(mealPlanId);
            if(mealPlanRecipes != null)
            {
                return Ok(mealPlanRecipes);
            }
            return StatusCode(404);
        }
        [HttpGet("{id}")]
        public ActionResult<MealPlan> GetMealPlanById(int id)
        {
            MealPlan mealPlan = mealPlanDao.GetMealPlanById(id);
            if(mealPlan !=null)
            {
                return Ok(mealPlan);
            }
            return StatusCode(404);
        }
    }
}
