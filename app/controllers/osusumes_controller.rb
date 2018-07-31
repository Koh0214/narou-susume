class OsusumesController < ApplicationController
  before_action :set_osusume, only: [:show, :edit, :update, :destroy]

  # GET /osusumes
  # GET /osusumes.json
  def index
    @osusumes = Osusume.all.reverse_order
  end

  # GET /osusumes/1
  # GET /osusumes/1.json
  def show
    @osusume = Osusume.where(:id => params[:id]).first
    if ENV["RACK_ENV"] == "production"
      @novels = @osusume.novels.order_like_count
    else
      @novels = @osusume.novels.order("like DESC")
    end
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

  def get_novel_info
    require 'net/http'

    # 参考URL https://qiita.com/awakia/items/bd8c1385115df27c15fa
    # TODO APIが死んだ時とかに、単純に500が返ってきて、javascriptエラーになるけどそれで良いのかな？
    novel_code = params[:url].gsub("https://ncode.syosetu.com/", "").gsub("http://ncode.syosetu.com/", "").gsub("/", "")
    request_url = "https://api.syosetu.com/novelapi/api/?out=json&of=t-s-w&ncode=" + novel_code

    api_response = Net::HTTP.get(URI.parse(request_url))
    novel_info = JSON.parse(api_response)

    # 入力されたURLが対応したURLだった場合、allcount(取得小説数)が1となる
    # そうじゃない場合はnullを入れて、javascriptの方でエラーを出す。TODO ここでのnullはundefinedになっているが、結果的に望む動作をしている。
    if novel_info[0]["allcount"] == 1
      @novel_title = novel_info[1]["title"]
      @novel_description = novel_info[1]["story"]
    else
      @novel_title = null
      @novel_description = null
    end


    # TODO ハーメルンとかをMechanizeでスクレイピングする場合を入れる
    # 暫定的にハーメルンから取得してみたけど、クラスssがたくさんありすぎて大量に取得する状態になっている。
    # harmeln_url = "https://syosetu.org/novel/145355/"
    # agent = Mechanize.new
    # agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
    # page = agent.get(harmeln_url)
    # @novel_title = page.at('title').inner_text
    # @novel_description = page.search('.ss.ss').inner_text
    #
    # respond_to do |format|
    #   format.js
    # end

  end

  def like
      @novel = Novel.find_by(id: params[:id])

      if @novel.like == nil
        @novel.update(like: 1)
      else
        @novel.update(like: @novel.like + 1)
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
