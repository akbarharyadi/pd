class PendaftaransController < ApplicationController
  before_action :set_pendaftaran, only: [:show, :edit, :update, :destroy]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  add_breadcrumb ' Tambah Pendaftaran'.html_safe, :pendaftarans_path
  include ApplicationHelper

  # GET /pendaftarans
  # GET /pendaftarans.json
  def index
    pendaftaran_scope = Pendaftaran.all
    if params[:filter_date] != '' and params[:filter_date] != nil
      date = params[:filter_date].split('s/d')
      pendaftaran_scope = pendaftaran_scope.where("tgl_daftar between '" + DateTime.parse(date[0]).strftime("%Y/%m/%d") + "' and '" + DateTime.parse(date[1]).strftime("%Y/%m/%d") + "'")
    end
    pendaftaran_scope = pendaftaran_scope.like(params[:filter]) if params[:filter] != ''
    @pendaftaran = smart_listing_create(:pendaftarans, pendaftaran_scope, partial: "pendaftarans/listing", default_sort: {created_at: "desc"})
  end

  # GET /pendaftarans/1
  # GET /pendaftarans/1.json
  def show
    add_breadcrumb @pendaftaran.npwpd
  end

  # GET /pendaftarans/new
  def new
    add_breadcrumb 'Buat Baru'
    @pendaftaran = Pendaftaran.new
    @pendaftaran.no_pendaftaran = generate_no_pendaftaran
    @pendaftaran.no_reg_pendaftaran = generate_no_pendaftaran + '/' + Date.today.year.to_s  
  end

  # GET /pendaftarans/1/edit
  def edit
    add_breadcrumb 'Edit : ' + @pendaftaran.npwpd
    @pendaftaran.tgl_npwpd = @pendaftaran.tgl_npwpd.strftime('%d-%m-%Y')
    @pendaftaran.tgl_daftar = @pendaftaran.tgl_daftar.strftime('%d-%m-%Y')
  end

  # POST /pendaftarans
  # POST /pendaftarans.json
  def create
    @pendaftaran = Pendaftaran.new(pendaftaran_params)

    respond_to do |format|
      if @pendaftaran.save
        format.html { redirect_to @pendaftaran, notice: 'Pendaftaran berhasil tersimpan' }
        format.json { render :show, status: :created, location: @pendaftaran }
      else
        format.html { render :new }
        format.json { render json: @pendaftaran.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pendaftarans/1
  # PATCH/PUT /pendaftarans/1.json
  def update
    respond_to do |format|
      if @pendaftaran.update(pendaftaran_params)
        format.html { redirect_to @pendaftaran, notice: 'Pendaftaran berhasil tersimpan' }
        format.json { render :show, status: :ok, location: @pendaftaran }
      else
        format.html { render :edit }
        format.json { render json: @pendaftaran.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pendaftarans/1
  # DELETE /pendaftarans/1.json
  def destroy
    @pendaftaran.destroy
    respond_to do |format|
      format.html { redirect_to pendaftarans_url, notice: 'Pendaftaran berhasil dihapus' }
      format.json { head :no_content }
    end
  end

  def daftar_wajib_pajak
    add_breadcrumb 'Cetak Daftar Wajib Pajak'
    pendaftaran_scope = Pendaftaran.all
    if params[:filter_date] != '' and params[:filter_date] != nil
      date = params[:filter_date].split('s/d')
      pendaftaran_scope = pendaftaran_scope.where("tgl_daftar between '" + DateTime.parse(date[0]).strftime("%Y/%m/%d") + "' and '" + DateTime.parse(date[1]).strftime("%Y/%m/%d") + "'")
    else
      params[:filter_date] = ""
    end
    @pendaftaran = pendaftaran_scope
    @wilayah = Wilayah.first
    @tanggal = params[:filter_date]
    respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Daftar Wajib Pajak " + params[:filter_date],
                  disposition: 'attachment'
        end
end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pendaftaran
      @pendaftaran = Pendaftaran.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pendaftaran_params
      params.require(:pendaftaran).permit(:no_pendaftaran, :nama_usaha, :alamat_usaha, :kecamatan_id, :kelurahan_id, :no_telp_usaha, :nama_pemilik, :alamat_pemilik, :no_telp_pemilik, :npwpd, :tgl_npwpd, :usaha_id, :filter, :no_reg_pendaftaran, :tgl_daftar, :filter_date, :filter)
    end
end
