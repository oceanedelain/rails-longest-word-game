require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = 10.times.map {('A'..'Z').to_a.sample}
  end

  def score
    grid = params[:grid].split(" ")
    guess = params[:word].upcase.chars
    if !(guess.all? { |letter| guess.count(letter) <= grid.count(letter) })
      @message = "#{params[:word]} is not in the grid"
    elsif !english_word?(params[:word])
      @message = "#{params[:word]} is not an english word"
    else
      @message = "#{params[:word]} : Congratulations"
    end
  end
end

def english_word?(word)
  response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end
