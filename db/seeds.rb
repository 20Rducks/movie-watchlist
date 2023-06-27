puts "Cleaning database..."

Movie.destroy_all

require 'open-uri'
require 'json'
url = 'http://tmdb.lewagon.com/movie/top_rated'
response = URI.open(url).read
movies = JSON.parse(response)['results']

puts "Creating Movies"

movies.each do |movie|
  Movie.create(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end

puts "Movies Created"
