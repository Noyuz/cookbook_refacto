require_relative "view"
require_relative 'cookbook'
require_relative "recipe"
require_relative "scrapper"

class Controller
  def self.list
    display_recipes
  end

  def self.mark_as_done
    display_recipes
    index = View.ask_user_for_index
    Cookbook.mark_done(index)
    display_recipes
  end

  def self.import
    ingredient = View.ask_user_for("ingredient")
    puts "Looking for #{ingredient} recipes on the Internet..."
    recipes = ScrapeAllrecipesService.call(ingredient)
    View.display(recipes)
    index = View.ask_user_for_index
    recipe = recipes[index]
    puts "Importing \"#{recipe.name}\"..."
    Cookbook.add_recipe(recipe)
  end

  def self.create
    name = View.ask_user_for("name")
    description = View.ask_user_for("description")
    rating = View.ask_user_for("rating")
    prep_time = View.ask_user_for("prep_time")
    recipe = Recipe.new(name: name, description: description, rating: rating, prep_time: prep_time)
    Cookbook.add_recipe(recipe)
    display_recipes
  end

  def self.destroy
    display_recipes
    index = View.ask_user_for_index
    Cookbook.remove_recipe(index)
    display_recipes
  end

  def self.display_recipes
    recipes = Cookbook.all
    View.display(recipes)
  end
end
