require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
   @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
  @output = ""
  @word = params[:words]
  @response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
  @json = JSON.parse(@response.read)
  @input = params[:words].upcase.chars
  @letters = params[:letters].chars
  if @input.all? { |letter| @input.count(letter) <= @letters.count(letter) }
    if @json["found"] == true
      @output = "Congratulations! #{@input.join} is a valid english word!"
    else
      @output = "Bad! The #{@input.join} is not a proper english word"
    end
  else
    @output = "Very bad! #{@input.join} is not a valid word"
  end
  return @output
end
end



