class MapController < ApplicationController
  def index

    @schools = School.all
    @students = Student.all
    @startpoints = Startpoint.first

  end
end
