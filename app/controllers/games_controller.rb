require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0..9).map { ('A'..'Z').to_a[rand(26)] }
  end
  def score
    url = 'https://wagon-dictionary.herokuapp.com/' + params[:word]
    response = open(url).read
    item = JSON.parse(response)
    # puts item["found"]
    @word = params[:word]
    @letters = params[:letters]

    if (@word.chars.each { |w| w.capitalize! } - @letters.delete('').chars).empty?
      @included = "built out of the original grid"
    else
      @included = "is not built out of the original grid"
    end
    if item['found']
      @valid = 'It is valid English word'
    else
      @valid = 'It is not a Englisch word'
    end
  end
end
