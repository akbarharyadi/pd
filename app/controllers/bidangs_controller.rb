class BidangsController < ApplicationController
  before_action :set_bidang, only: [:show, :edit, :update, :destroy]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  add_breadcrumb ' Index Bidang'.html_safe, :bidangs_path

  # GET /bidangs
  # GET /bidangs.json
  def index
    bidangs_scope = Bidang.all
    bidangs_scope = bidangs_scope.like(params[:filter]) if params[:filter]
    @bidangs = smart_listing_create(:bidangs, bidangs_scope, partial: "bidangs/listing", default_sort: {kode_bidang: "asc"})
  end

  # GET /bidangs/1
  # GET /bidangs/1.json
  def show
     add_breadcrumb @bidang.nama_bidang.capitalize
  end

  # GET /bidangs/new
  def new
    add_breadcrumb 'Buat Baru'
    @bidang = Bidang.new
  end

  # GET /bidangs/1/edit
  def edit
    add_breadcrumb 'Edit : ' + @bidang.nama_bidang.capitalize
  end

  # POST /bidangs
  # POST /bidangs.json
  def create
    @bidang = Bidang.new(bidang_params)

    respond_to do |format|
      if @bidang.save
        format.html { redirect_to @bidang, notice: 'Bidang berhasil tersimpan.' }
        format.json { render :show, status: :created, location: @bidang }
      else
        format.html { render :new }
        format.json { render json: @bidang.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bidangs/1
  # PATCH/PUT /bidangs/1.json
  def update
    respond_to do |format|
      if @bidang.update(bidang_params)
        format.html { redirect_to @bidang, notice: 'Bidang berhasil tersimpan.' }
        format.json { render :show, status: :ok, location: @bidang }
      else
        format.html { render :edit }
        format.json { render json: @bidang.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bidangs/1
  # DELETE /bidangs/1.json
  def destroy
    @bidang.destroy
    respond_to do |format|
      format.html { redirect_to bidangs_url, notice: 'Bidang berhasil terhapus.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bidang
      @bidang = Bidang.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bidang_params
      params.require(:bidang).permit(:kode_bidang, :nama_bidang, :filter)
    end
end
