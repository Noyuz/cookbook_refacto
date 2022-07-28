require "csv"
require_relative "recipe"

class Cookbook
  def initialize(csv_file)
    @recipes = [] # <--- <Recipe> instances
    @csv_file = csv_file
    load_csv
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_to_csv
  end

  def all
    @recipes
  end

  def mark_done(index)
    recipe = @recipes[index]
    recipe.done!
    save_to_csv
  end


  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:done] = row[:done] == "true"
      @recipes << Recipe.new(row)
    end
  end

  def save_to_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ["name", "description", "rating", "prep_time", "done"]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end
end
