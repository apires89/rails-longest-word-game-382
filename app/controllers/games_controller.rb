require "open-uri"
class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    #get information from the params and assign it to variables
    @letters = params[:letters].split(" ")
    @word = params[:word].upcase.split("")
    #check if word is included in grid

    #if result == [] then its true
    if word_in_grid.empty?
      #if word is in the dictionary
      if check_valid_word(@word) == true
        @result = "CONGRATULATIONS! #{params[:word].upcase} is a valid English word!"
      else
        #word not in dictionary
        @result = "Sorry, but #{params[:word].upcase} is not a valid English word!"
      end
    else
      #word is not built from the letters
      @result = "Sorry, but #{params[:word].upcase} can't be built out of #{params[:letters]}"
    end
  end


  private

  def word_in_grid
    return @word - @letters
  end

  def check_valid_word(word)
    #create the method to check if word is valid english word
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    response = JSON.parse(open(url).read)
    response["found"]
  end
end
