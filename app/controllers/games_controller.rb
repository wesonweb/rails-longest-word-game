require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    # @included = @word.chars.all? do |char|
    #   @letters.include?(char)
    # end
    # 1. check to see if @word letters are all in @letters array
    @included = @word.chars.all? do |char|
      @word.count(char) <= @letters.count(char)
    end
    # 3. if #1 is valid then call the API and pass in the @word as search param
    english_word?(@word)
  end
end

def english_word?(word)
  # 4. check the API to see if the word is there
  # 5. if word is not in API display msg saying not a word
  # 6. if word is there then display msg saying congrats
  response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
  @dictionary = JSON.parse(response.read)
end
