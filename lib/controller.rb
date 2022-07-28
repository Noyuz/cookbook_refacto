require_relative "view"
require_relative "recipe"
require_relative "scrapper"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  # USER ACTIONS

  def list
    display_recipes
  end

  def mark_as_done
    display_recipes
    index = @view.ask_user_for_index
    @cookbook.mark_done(index)
    display_recipes
  end

  def import
    # demander à l’utilisateur un mot-clé à rechercher
    ingredient = @view.ask_user_for("ingredient")
    puts "Looking for #{ingredient} recipes on the Internet..."
    # envoyer une requête HTTP au site Web de recettes avec le mot-clé
    recipes = ScrapeAllrecipesService.new(ingredient).call
    # les afficher sous forme de liste indexée
    @view.display(recipes)
    # demander à l’utilisateur quelle recette il veut importer (demander un indice)
    index = @view.ask_user_for_index
    recipe = recipes[index]
    puts "Importing \"#{recipe.name}\"..."
    # l’ajouter au Cookbook
    @cookbook.add_recipe(recipe)
  end

  def create
    # 1. Ask user for a name (view)
    name = @view.ask_user_for("name")
    # 2. Ask user for a description (view)
    description = @view.ask_user_for("description")
    # 3. Ask user for a rating (view)
    rating = @view.ask_user_for("rating")
    # 4. Ask user for a prep_time (view)
    prep_time = @view.ask_user_for("prep_time")
    # 5. Create recipe (model)
    recipe = Recipe.new(name: name, description: description, rating: rating, prep_time: prep_time)
    # 6. Store in cookbook (repo)
    @cookbook.add_recipe(recipe)
    # 7. Display
    display_recipes
  end

  def destroy
    # 1. Display recipes
    display_recipes
    # 2. Ask user for index (view)
    index = @view.ask_user_for_index
    # 3. Remove from cookbook (repo)
    @cookbook.remove_recipe(index)
    # 4. Display
    display_recipes
  end

  private

  def display_recipes
    # 1. Get recipes (repo)
    recipes = @cookbook.all
    # 2. Display recipes in the terminal (view)
    @view.display(recipes)
  end
end
