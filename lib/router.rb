require_relative 'controller'

class Router
  def self.run
    @running = true
    puts "Welcome to the Cookbook!"
    puts "           --           "

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  def self.route_action(action)
    case action
    when 1 then Controller.list
    when 2 then Controller.create
    when 3 then Controller.destroy
    when 4 then Controller.import
    when 5 then Controller.mark_as_done
    when 6 then stop
    else
      puts "Please press 1, 2, 3, 4, 5 or 6"
    end
  end

  def self.stop
    @running = false
  end

  def self.display_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all recipes"
    puts "2 - Create a new recipe"
    puts "3 - Destroy a recipe"
    puts "4 - Import recipes from the Internet"
    puts "5 - Mark recipe as done"
    puts "6 - Stop and exit the program"
    puts ""
    print "> "
  end
end
