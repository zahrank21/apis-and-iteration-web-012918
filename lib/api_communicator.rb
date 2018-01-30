require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  char_films = []
  character_hash["results"].each do |in_char_hash|
    if in_char_hash["name"].downcase == character
      char_films = in_char_hash["films"]
    end
  end

  if char_films == []
    counter = 2
    while counter <= 16 || char_films == []
      all_characters = RestClient.get('http://www.swapi.co/api/people/' + counter.to_s)
      character_hash = JSON.parse(all_characters)
        if character_hash["name"].downcase == character
          char_films = character_hash["films"]
        end
      counter += 1
    end
  end


  #if the character isnt in the url
  #need to add additional number to url starting with 1
  #if chracter isnt in the url, increment by 1 until 88
  # if after url with 88 return no character found


  films_hash = get_films_from_url(char_films)
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def get_films_from_url(url_arr)
  url_arr.map do |url|
    film = RestClient.get(url)
    film = JSON.parse(film)
  end
end

def parse_character_movies(films_hash)
  films_hash.each do |hash|
    puts hash["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
