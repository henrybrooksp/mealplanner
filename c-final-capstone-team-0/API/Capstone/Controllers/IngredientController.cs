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
    [Route("ingredient/")]
    [ApiController]
    [Authorize]
    public class IngredientController : ControllerBase
    {
        private readonly IIngredientDao ingredientDao;

        public IngredientController(IIngredientDao _ingredientDao)
        {
            ingredientDao = _ingredientDao;
        }
        [HttpGet("recipe/{recipeId}")]
        public IActionResult GetIngredientsByRecipe(int recipeId)
        {
            List<RecipeIngredient> recipeIngredients = ingredientDao.GetIngredientsByRecipe(recipeId);
            if(recipeIngredients!=null)
            {
                return Ok(recipeIngredients);
            }
            return StatusCode(404);
        }
        [HttpGet("all")]
        public IActionResult GetAllIngredients()
        {
            List<Ingredient> ingredients = ingredientDao.GetAllIngredients();
            if(ingredients != null)
            {
                return Ok(ingredients);
            }
            return StatusCode(503);
        }
        [HttpGet("{ingredientId}")]
        public IActionResult GetIngredientById(int ingredientId)
        {
            Ingredient ingredient = ingredientDao.GetIngredientById(ingredientId);
            if(ingredient!=null)
            {
                return Ok(ingredient);
            }
            return StatusCode(503);
        }
        [HttpPost("new")]
        public ActionResult<Ingredient> CreateIngredient(Ingredient newIngredient)
        {
            Ingredient added = ingredientDao.CreateIngredient(newIngredient);
            return Created($"/ingredient/new/{added.IngredientId}", added);
        }
        [HttpPost("recipe/add")]
        public ActionResult<List<RecipeIngredient>> AddRecipeIngredient(AddedRecipeIngredient ingredient)
        {
            List<RecipeIngredient> added = ingredientDao.AddRecipeIngredient(ingredient);
            return Created($"/ingredient/recipe/add/{added[added.Count-1].IngredientId}", added);
        }
        [HttpGet("grocerylist/{userId}")]
        public ActionResult<List<string>> GetGroceryList(int userId)
        {
            List<string> groceryList = ingredientDao.GetUserGroceryList(userId);
            if(groceryList!= null)
            {
                return Ok(groceryList);
            }
            return StatusCode(404);
        }
    }
}
