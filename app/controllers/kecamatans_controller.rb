class KecamatansController < ApplicationController
  before_action :set_kecamatan, only: [:show, :edit, :update, :destroy]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  add_breadcrumb ' Index Kecamatan'.html_safe, :kecamatans_path

  # GET /kecamatans
  # GET /kecamatans.json
  def index
    kecamatan_scope = Kecamatan.all
    kecamatan_scope = kecamatan_scope.like(params[:filter]) if params[:filter]
    @kecamatan = smart_listing_create(:kecamatans, kecamatan_scope, partial: "kecamatans/listing", default_sort: {kode: "asc"})
  end

  # GET /kecamatans/1
  # GET /kecamatans/1.json
  def show
    add_breadcrumb @kecamatan.nama.capitalize
  end

  # GET /kecamatans/new
  def new
    add_breadcrumb 'Buat Baru'
    @kecamatan = Kecamatan.new
  end

  # GET /kecamatans/1/edit
  def edit
    add_breadcrumb 'Edit : ' + @kecamatan.nama.capitalize
  end

  # POST /kecamatans
  # POST /kecamatans.json
  def create
    @kecamatan = Kecamatan.new(kecamatan_params)

    respond_to do |format|
      if @kecamatan.save
        format.html { redirect_to @kecamatan, notice: 'Kecamatan berhasil tersimpan.' }
        format.json { render :show, status: :created, location: @kecamatan }
      else
        format.html { render :new }
        format.json { render json: @kecamatan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kecamatans/1
  # PATCH/PUT /kecamatans/1.json
  def update
    respond_to do |format|
      if @kecamatan.update(kecamatan_params)
        format.html { redirect_to @kecamatan, notice: 'Kecamatan berhasil diupdate.' }
        format.json { render :show, status: :ok, location: @kecamatan }
      else
        format.html { render :edit }
        format.json { render json: @kecamatan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kecamatans/1
  # DELETE /kecamatans/1.json
  def destroy
    @kecamatan.destroy
    respond_to do |format|
      format.html { redirect_to kecamatans_url, notice: 'Kecamatan berhasil dihapus.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kecamatan
      @kecamatan = Kecamatan.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kecamatan_params
      params.require(:kecamatan).permit(:kode, :nama, :filter)
    end
end
