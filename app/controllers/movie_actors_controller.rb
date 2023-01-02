class MovieActorsController < ApplicationController
  def create
    MovieActor.create!(actor_id: params[:actor_identification], movie_id: params[:movie_id])
    redirect_to "/movies/#{params[:movie_id]}"
  end
end