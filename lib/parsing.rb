require "nokogiri"
require_relative 'recipe'

file = "strawberry.html"
doc = Nokogiri::HTML(File.open(file), nil, "utf-8")

cards = doc.search('.card__recipe').first(5)
recipes = []

cards.each do |card|
  name = card.search('.card__title').text.strip
  description = card.search('.card__summary').text.strip
  rating = card.search('.review-star-text').text.split[1]
  show_url = card.search('.card__titleLink')[0]['href']
  #recipes << Recipe.new(name, description)
end
