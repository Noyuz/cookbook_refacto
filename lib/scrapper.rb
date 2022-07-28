require "open-uri"
require "nokogiri"

class ScrapeAllrecipesService
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    url = "https://www.allrecipes.com/search/results/?search=#{@ingredient}" # the url of the web page you want to scrape
    html = URI.open(url) # open the html of the page
    doc = Nokogiri::HTML(html) # create a nokogiri doc based on that html

    recipes = []
    cards = doc.search('.card__recipe').first(5)

    # parser le document HTML pour extraire les 5 premières recettes suggérées et les stocker dans un Array
    cards.each do |card|
      name = card.search('.card__title').text.strip
      description = card.search('.card__summary').text.strip
      rating = card.search('.review-star-text').text.split[1] # ou .text.strip.match(/\d\.?\d*/)[0]
      show_url = card.search('.card__titleLink')[0]['href']
      show_html = URI.open(show_url)
      show_doc = Nokogiri::HTML(show_html)
      prep_element = show_doc.search('.recipe-meta-item').find do |element|
        element.text.strip.match?(/prep/i)
      end
      prep_time = prep_element ? prep_element.text.strip.match(/prep:\s+(\w* \w*)/i)[1] : nil
      recipes << Recipe.new(name: name, description: description, rating: rating, prep_time: prep_time)
    end
    return recipes
  end
end
