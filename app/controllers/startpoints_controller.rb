class StartpointsController < ApplicationController
  before_action :set_startpoint, only: [:show, :edit, :update, :destroy]

  # GET /startpoints
  # GET /startpoints.json
  def index
    @startpoints = Startpoint.all
  end

  # GET /startpoints/1
  # GET /startpoints/1.json
  def show
  end

  # GET /startpoints/new
  def new
    @startpoint = Startpoint.new
  end

  # GET /startpoints/1/edit
  def edit
  end

  # POST /startpoints
  # POST /startpoints.json
  def create
    @startpoint = Startpoint.new(startpoint_params)

    respond_to do |format|
      if @startpoint.save
        format.html { redirect_to @startpoint, notice: 'Startpoint was successfully created.' }
        format.json { render :show, status: :created, location: @startpoint }
      else
        format.html { render :new }
        format.json { render json: @startpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /startpoints/1
  # PATCH/PUT /startpoints/1.json
  def update
    respond_to do |format|
      if @startpoint.update(startpoint_params)
        format.html { redirect_to @startpoint, notice: 'Startpoint was successfully updated.' }
        format.json { render :show, status: :ok, location: @startpoint }
      else
        format.html { render :edit }
        format.json { render json: @startpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /startpoints/1
  # DELETE /startpoints/1.json
  def destroy
    @startpoint.destroy
    respond_to do |format|
      format.html { redirect_to startpoints_url, notice: 'Startpoint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_startpoint
      @startpoint = Startpoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def startpoint_params
      params.require(:startpoint).permit(:address_id)
    end
end
