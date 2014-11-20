require 'ant_tsp'
class TspController < ActionController::Base
  def generate_new_route
    ant_tsp = AntTsp.new
    puts ant_tsp.readGraph params[:turn], params[:going] == "going"
    ant_tsp.solve
    @bestTour = ant_tsp.bestTour
    @points = ant_tsp.points
    render "route"
  end
end
