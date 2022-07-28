class View
  def self.display(recipes)
    recipes.each_with_index do |recipe, index|
      status = recipe.done? ? "[X]" : "[ ]"
      puts "#{index + 1}. #{status} #{recipe.name}: #{recipe.description} (#{recipe.rating}/5) -- #{recipe.prep_time}"
    end
  end

  def self.ask_user_for(something)
    puts "#{something.capitalize}?"
    print "> "
    return gets.chomp
  end

  def self.ask_user_for_index
    puts "Index?"
    print "> "
    return gets.chomp.to_i - 1
  end

  def self.ask_user_for_rating
    puts "Rating? (5 max)"
    print "> "
    return gets.chomp
  end
end
