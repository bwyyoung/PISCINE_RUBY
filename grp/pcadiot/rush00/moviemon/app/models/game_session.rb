require 'uri'
# require 'json'
require 'net/http'

class GameSession

  def initialize
  end

  def save
    unless File.exist?("public/save.json")
      File.open("public/save.json", "w+") do |f|
        tab = [{}, {}, {}]
        tab[$player[:slot] - 1] = $player
        f.write(JSON.pretty_generate(tab))
      end
    else
      tab = JSON.parse(File.read("public/save.json"))
      File.open("public/save.json", "w+") do |f|
        tab[$player[:slot] - 1] = $player
        f.write(JSON.pretty_generate(tab))
      end
    end
  end

  def load
    file = File.read("public/save.json")
    data_hash = JSON.parse(file, :symbolize_names => true)
    $player = data_hash[$player[:slot] - 1]
  end
  

  def get_movie
    @my_movies = []
    30.times { @my_movies << JSON.parse(Net::HTTP.get(URI("https://random-movie.herokuapp.com/random"))) }
    @my_moviemons = []
    @my_movies.each do |movie|
      @my_moviemons << {
        title: movie["Title"],
        year: movie["Year"],
        director: movie["Director"],
        genre: movie["Genre"],
        rating: movie["Ratings"][0]["Value"],
        poster: movie["Poster"],
        synopsis: movie["Plot"],
        strength: movie["Ratings"][0]["Value"].to_i,
        life: movie["Ratings"][0]["Value"].to_i * 2
      } 
    end
    @my_moviemons
  end

end