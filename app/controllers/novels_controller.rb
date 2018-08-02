class NovelsController < ApplicationController
  before_action :set_novel, only: [:show, :edit, :update, :destroy]

  # GET /novels
  # GET /novels.json
  def index
    @novels = Novel.all
  end

  # GET /novels/1
  # GET /novels/1.json
  def show
    @osusumes = Osusume.order("RANDOM()").limit(7)
    @novel = Novel.where(:id => params[:id]).first
    @comment = Comment.new
    @comments = @novel.comments.order(:id)
  end

  # GET /novels/new
  def new
    @novel = Novel.new
  end

  # GET /novels/1/edit
  def edit
  end

  # POST /novels
  # POST /novels.json
  def create
    @novel = Novel.new(novel_params)

    respond_to do |format|
      if @novel.save
        format.html { redirect_to root_path, notice: 'Novel was successfully created.' }
        format.json { render :show, status: :created, location: @novel }
        format.js
      else
        format.html { render :new }
        format.json { render json: @novel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /novels/1
  # PATCH/PUT /novels/1.json
  def update
    respond_to do |format|
      if @novel.update(novel_params)
        format.html { redirect_to @novel, notice: 'Novel was successfully updated.' }
        format.json { render :show, status: :ok, location: @novel }
      else
        format.html { render :edit }
        format.json { render json: @novel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /novels/1
  # DELETE /novels/1.json
  def destroy
    @novel.destroy
    respond_to do |format|
      format.html { redirect_to novels_url, notice: 'Novel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def comment_count_up
      @comment = Comment.find_by(id: params[:id])
      if @comment.up == nil
        @comment.update(up: 1)
      else
        @comment.update(up: @comment.up + 1)
      end
  end

  def comment_count_down
      @comment = Comment.find_by(id: params[:id])
      if @comment.down == nil
        @comment.update(down: 1)
      else
        @comment.update(down: @comment.down + 1)
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_novel
      @novel = Novel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def novel_params
      params.require(:novel).permit(:title, :description, :url, :like, :osusume_id)
    end
end
