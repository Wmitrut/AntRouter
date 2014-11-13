require 'ant_tsp'
class TspController < ActionController::Base
  def generate_new_route
    ant_tsp = AntTsp.new
    puts ant_tsp.readGraph params[:turn], params[:going] == "going"
    render :text => ant_tsp.solve
  end
end
