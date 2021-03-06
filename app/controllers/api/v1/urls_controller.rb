class Api::V1::UrlsController < ApplicationController
  before_action :set_url, only: [:show, :edit, :update, :destroy]
  protect_from_forgery
  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.get_top(25)
    # render json: @urls
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
    render json: @url
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # GET /urls/1/edit
  def edit
  end

  def top_100
    @urls = Url.get_top(top_limit=100)
    render json: @urls
  end

  def decode_url
    url_decoded = Url.get_entire_url_decoded(params[:word])
    print(url_decoded)
    if url_decoded.nil?
      render :file => 'public/404.html', :status => :not_found, :layout => false
    else
      redirect_to url_decoded.url
    end
  end

  # POST /urls
  # POST /urls.json
  def create
    @url = Url.new(url_params)
    respond_to do |format|
      if @url.save
            #format.html { redirect_to @url, notice: 'Url was successfully created.' }
        FetchUrlWorker.perform_async(@url.id)
        format.json { render json: {
                short_url: "#{request.protocol}#{request.host_with_port}/#{@url.short_url}",
                status: :created,
                location: @url }
            }
      else
        # format.html { render :new }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /urls/1
  # PATCH/PUT /urls/1.json
  def update
    respond_to do |format|
      if @url.update(url_params)
        format.html { redirect_to @url, notice: 'Url was successfully updated.' }
        format.json { render :show, status: :ok, location: @url }
      else
        format.html { render :edit }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url, notice: 'Url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.permit(:url)
    end
end
