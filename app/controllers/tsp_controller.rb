require 'ant_tsp'
class TspController < ActionController::Base
  def generate_new_route
    ant_tsp = AntTsp.new
    ant_tsp.readGraph("/home/wmitrut/code/tcc_final/antrouter/doc/tspadata4.txt")
    render :text => ant_tsp.solve
  end
end
