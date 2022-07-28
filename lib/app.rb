require_relative 'cookbook'
require_relative 'router'

# loading csv
Cookbook.load_csv

# Start the app
Router.run
