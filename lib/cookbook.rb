require "csv"
require_relative "recipe"

class Cookbook
  @recipes = []
  @csv_file = File.join(__dir__, 'recipes.csv')

  def self.add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def self.remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def self.all
    @recipes
  end

  def self.mark_done(index)
    recipe = @recipes[index]
    recipe.done!
    save_csv
  end

  def self.load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:done] = row[:done] == "true"
      @recipes << Recipe.new(row)
    end
  end

  def self.save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ["name", "description", "rating", "prep_time", "done"]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end
end
