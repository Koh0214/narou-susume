class OsusumesController < ApplicationController
  before_action :set_osusume, only: [:show, :edit, :update, :destroy]

  # GET /osusumes
  # GET /osusumes.json
  def index
    @osusumes = Osusume.all
  end

  # GET /osusumes/1
  # GET /osusumes/1.json
  def show
    @osusume = Osusume.where(:id => params[:id]).first
    @novels = @osusume.novels
    @novel = Novel.new
  end

  # GET /osusumes/new
  def new
    @osusume = Osusume.new
  end

  # GET /osusumes/1/edit
  def edit
  end

  # POST /osusumes
  # POST /osusumes.json
  def create
    @osusume = Osusume.new(osusume_params)

    respond_to do |format|
      if @osusume.save
        format.html { redirect_to @osusume, notice: 'Osusume was successfully created.' }
        format.json { render :show, status: :created, location: @osusume }
      else
        format.html { render :new }
        format.json { render json: @osusume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /osusumes/1
  # PATCH/PUT /osusumes/1.json
  def update
    respond_to do |format|
      if @osusume.update(osusume_params)
        format.html { redirect_to @osusume, notice: 'Osusume was successfully updated.' }
        format.json { render :show, status: :ok, location: @osusume }
      else
        format.html { render :edit }
        format.json { render json: @osusume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /osusumes/1
  # DELETE /osusumes/1.json
  def destroy
    @osusume.destroy
    respond_to do |format|
      format.html { redirect_to osusumes_url, notice: 'Osusume was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_osusume
      @osusume = Osusume.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def osusume_params
      params.require(:osusume).permit(:title, :short_title)
    end
end
