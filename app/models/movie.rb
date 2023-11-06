require 'themoviedb'
class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.movie_rating(movie_id)
    release_dates = Tmdb::Movie.releases(movie_id)
    us_release = release_dates['countries'].find { |result| result['iso_3166_1'] == 'US' && result['certification'] != "" }
    us_release["certification"] if us_release
  end

  class Movie::InvalidKeyError < StandardError ; end

  def self.find_in_tmdb(string)
    begin
      Tmdb::Api.key('f4702b08c0ac6ea5b51425788bb26562')
      movies = Tmdb::Movie.find(string)
      list_of_valid_movies = []
      if movies.nil?
        list_of_valid_movies
      else
        movies.each do |movie|
          rating = movie_rating(movie.id)
          movie_hash = {:tmdb_id=>movie.id, :title=>movie.title, :rating=>rating, :release_date=>movie.release_date}
          unless rating.nil?
            list_of_valid_movies<<movie_hash
          end
        end
        list_of_valid_movies
      end
    rescue Tmdb::InvalidApiKeyError
      raise Movie::InvalidKeyError, 'Invalid API key'
    end
  end

  def self.create_from_tmdb(id)
    movie = Tmdb::Movie.detail(id)
    rating = movie_rating(id)
    final_movie = {:title => movie['title'], :rating => rating, :description => movie['overview'], :release_date => movie['release_date']}
    Movie.create!(final_movie)
  end

end
