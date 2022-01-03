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
    [Route("recipe/")]
    [ApiController]

    public class RecipeController : ControllerBase
    {
        private readonly IRecipeDao recipeDao;

        public RecipeController(IRecipeDao _recipeDao)
        {
            recipeDao = _recipeDao;
        }

        [HttpGet("all")]//get recipe details
        public IActionResult GetAllRecipes()
        {
            List<MealRecipe> allRecipes = recipeDao.GetAllRecipes();
            if(allRecipes!=null)
            {
                return Ok(allRecipes);
            }
            return StatusCode(503);
        }
        [HttpGet("{recipeId}")]//recipe details
        public IActionResult GetRecipe(int recipeId)
        {
            MealRecipe mealRecipe = recipeDao.GetRecipe(recipeId);
            if(mealRecipe != null)
            {
                return Ok(mealRecipe);
            }
            return StatusCode(404);
        }
        [HttpGet("user/{userId}")]//get recipes by user
        public IActionResult GetRecipesByUser(int userId)
        {
            List<MealRecipe> userRecipes = recipeDao.GetRecipesByUser(userId);
            if(userRecipes != null)
            {
                return Ok(userRecipes);
            }
            return StatusCode(404);
        }
        [HttpGet("search/ingredient/{ingredient}")]
        public IActionResult SearchByIngredient(string ingredient)
        {
            List<MealRecipe> ingredientRecipes = recipeDao.SearchByIngredient(ingredient);
            if(ingredientRecipes != null)
            {
                return Ok(ingredientRecipes);
            }
            return StatusCode(404);
        }
        [HttpGet("search/category/{category}")]
        public IActionResult SearchByCategory(string category)
        {
            List<MealRecipe> categoryRecipes = recipeDao.SearchByCategory(category);
            if(categoryRecipes!=null)
            {
                return Ok(categoryRecipes);
            }
            return StatusCode(404);
        }
        [HttpPost("add")]//add a recipe to my recipe
        public ActionResult<UserRecipe> AddUserRecipe(UserRecipe userRecipe)
        {
            UserRecipe addedRecipe = recipeDao.AddUserRecipe(userRecipe);
            return Created($"/recipe/add/{addedRecipe.UserId}/{addedRecipe.RecipeId}", addedRecipe);
        }
        [HttpPost("create")]//create new recipe
        public ActionResult<UserRecipe> CreateNewRecipe(Recipe recipe)
        {
            UserRecipe createdRecipe = recipeDao.CreateNewRecipe(recipe);
            return Created($"/recipe/create/{createdRecipe.UserId}", createdRecipe);
        }
        [HttpPost("mealplan/add")]
        public ActionResult<MealRecipe> AddRecipeToMealPlan(AddedMealRecipe mealPlanRecipe)
        {
            MealRecipe added = recipeDao.AddRecipeToMealPlan(mealPlanRecipe);
            return Created($"mealplan/add/{added.RecipeId}", added);
        }
        [HttpPut("edit/{id}")]
        public IActionResult UpdateRecipe(MealRecipe updatedRecipe, int id)
        {
            MealRecipe recipe = recipeDao.GetRecipe(id);
            if(recipe == null)
            {
                return NotFound();
            }
            if (updatedRecipe.RecipeId == recipe.RecipeId)
            {
                MealRecipe finalRecipe = recipeDao.UpdateRecipe(updatedRecipe);
                return Ok(finalRecipe);
            }
            return StatusCode(403);
        }
        [HttpDelete("mealplan/{mpId}/recipe/{rId}")]
        public IActionResult DeleteRecipeFromMealPlan(int mpId, int rId)
        {
            AddedMealRecipe delete = new AddedMealRecipe();
            delete.MealPlanId = mpId;
            delete.RecipeId = rId;
            bool final = recipeDao.DeleteRecipeFromMealPlan(delete);
            if(final == true)
            {
                return Ok(final);
            }
            return StatusCode(504);
        }
    }
}
