require 'ant_tsp'
class TspController < ActionController::Base
  def generate_new_route
    ant_tsp = AntTsp.new
    puts ant_tsp.readGraph params[:turn], params[:going] == "going"
    ant_tsp.solve
    @bestTour = ant_tsp.bestTour
    @points = ant_tsp.points
    r = Route.create
    r.item_routes ||= []
    @points.each_with_index do |x, i|
      if x.is_a? Turn
        x = x.school
      end
      r.item_routes << ItemRoute.create( order:i , routable:x)
    end
    r.save!
    render "route"
  end
end
