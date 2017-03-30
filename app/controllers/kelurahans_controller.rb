class KelurahansController < ApplicationController
  before_action :set_kelurahan, only: [:show, :edit, :update, :destroy]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  add_breadcrumb ' Index kelurahan'.html_safe, :kelurahans_path
  # GET /kelurahans
  # GET /kelurahans.json
  def index
    kelurahan_scope = Kelurahan.all
    kelurahan_scope = kelurahan_scope.like(params[:filter]) if params[:filter]
    @kelurahan = smart_listing_create(:kelurahans, kelurahan_scope, partial: "kelurahans/listing", default_sort: {kode: "asc"})
  end

  # GET /kelurahans/1
  # GET /kelurahans/1.json
  def show
    add_breadcrumb @kelurahan.nama.capitalize
  end

  # GET /kelurahans/new
  def new
    add_breadcrumb 'Buat Baru'
    @kelurahan = Kelurahan.new
  end

  # GET /kelurahans/1/edit
  def edit
    add_breadcrumb 'Edit ' + @kelurahan.nama.capitalize
  end

  # POST /kelurahans
  # POST /kelurahans.json
  def create
    @kelurahan = Kelurahan.new(kelurahan_params)

    respond_to do |format|
      if @kelurahan.save
        format.html { redirect_to @kelurahan, notice: 'kelurahan berhasil tersimpan' }
        format.json { render :show, status: :created, location: @kelurahan }
      else
        format.html { render :new }
        format.json { render json: @kelurahan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kelurahans/1
  # PATCH/PUT /kelurahans/1.json
  def update
    respond_to do |format|
      if @kelurahan.update(kelurahan_params)
        format.html { redirect_to @kelurahan, notice: 'Kelurahan berhasil tersimpan' }
        format.json { render :show, status: :ok, location: @kelurahan }
      else
        format.html { render :edit }
        format.json { render json: @kelurahan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kelurahans/1
  # DELETE /kelurahans/1.json   
  def destroy
    @kelurahan.destroy
    respond_to do |format|
      format.html { redirect_to kelurahans_url, notice: 'kelurahan berhasil dihapus.' }
      format.json { head :no_content }
    end
  end

  def update_kelurahan
    id = ''
    if params[:kecamatan_id] != ''
      id = params[:kecamatan_id]
    else
      id = 0
    end
    @kelurahans = Kelurahan.where("kecamatan_id = ?", id)
    render json: @kelurahans
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kelurahan
      @kelurahan = Kelurahan.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kelurahan_params
      params.require(:kelurahan).permit(:kode, :nama, :filter, :kecamatan_id)
    end
end
