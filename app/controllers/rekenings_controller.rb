class RekeningsController < ApplicationController
  before_action :set_rekening, only: [:show, :edit, :update, :destroy]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  add_breadcrumb ' Index Rekening'.html_safe, :rekenings_path
  # GET /rekenings
  # GET /rekenings.json
  def index
    rekening_scope = Rekening.all
    if params[:filter] != '' and params[:filter] != nil
      rekening_scope = rekening_scope.where("trim(upper(nama_rekening)) like trim(upper('%" + params[:filter] + "%'))")
    end
      if params[:filter_induk_rekening] != '' and params[:filter_induk_rekening] != nil
        rekening_scope = rekening_scope.where("kode = '" + params[:filter_induk_rekening] + "'")
      end
      if params[:filter_tahun_rekening] != '' and params[:filter_tahun_rekening] != nil
        rekening_scope = rekening_scope.where("tahun = " + params[:filter_tahun_rekening])
      end
    @rekening = smart_listing_create(:rekenings, rekening_scope, partial: "rekenings/listing", default_sort: {tahun: "desc", kode: "asc", jenis_kode: "asc", turunan_kode: 'asc'})
  end

  # GET /rekenings/1
  # GET /rekenings/1.json
  def show
    add_breadcrumb @rekening.nama_rekening.capitalize
  end

  # GET /rekenings/new
  def new
    add_breadcrumb 'Buat Baru'
    @rekening = Rekening.new
  end

  # GET /rekenings/1/edit
  def edit
  end

  # POST /rekenings
  # POST /rekenings.json
  def create
    params[:rekening][:tarif] = params[:rekening][:tarif].gsub('.', '').gsub(',', '.')
    @rekening = Rekening.new(rekening_params)
    respond_to do |format|
      if @rekening.save
        format.html { redirect_to @rekening, notice: 'Rekening berhasil tersimpan.' }
        format.json { render :show, status: :created, location: @rekening }
      else
        format.html { render :new }
        format.json { render json: @rekening.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rekenings/1
  # PATCH/PUT /rekenings/1.json
  def update
    respond_to do |format|
      params[:rekening][:tarif] = params[:rekening][:tarif].gsub('.', '').gsub(',', '.')
      if @rekening.update(rekening_params)
        format.html { redirect_to @rekening, notice: 'Rekening berhasil tersimpan.' }
        format.json { render :show, status: :ok, location: @rekening }
      else
        format.html { render :edit }
        format.json { render json: @rekening.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rekenings/1
  # DELETE /rekenings/1.json
  def destroy
    @rekening.destroy
    respond_to do |format|
      format.html { redirect_to rekenings_url, notice: 'Rekening berhasil terhapus.' }
      format.json { head :no_content }
    end
  end

  def update_rekening
    id = ''
    if params[:tahun_rekening] != ''
      id = params[:tahun_rekening]
    else
      id = 0
    end
    if params[:turunan] == 'true'
      @rekenings = Rekening.where("persen !=0 and persen is not null and jenis_kode != '00' and kode= '" + params[:kode] + "' and tahun = " + id).order(kode: "asc", jenis_kode: "asc", turunan_kode: 'asc')
    else
      @rekenings = Rekening.where("jenis_kode='00' and turunan_kode='00' and tahun = ?", id).order(kode: "asc", jenis_kode: "asc", turunan_kode: 'asc')
    end
    render json: @rekenings
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rekening
      @rekening = Rekening.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rekening_params
      params.require(:rekening).permit(:kode, :jenis_kode, :turunan_kode, :tahun, :tarif, :persen, :nama_rekening, :filter, :filter_induk_rekening, :filter_tahun_rekening, :turunan)
    end
end
