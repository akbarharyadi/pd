class PendataansController < ApplicationController
  before_action :set_pendataan, only: [:show, :edit, :update, :destroy]
  before_action :set_rekening, only: [:show, :edit, :index, :new, :create, :update]
  before_action :set_parameter, only: [:create, :update]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  include ApplicationHelper

  # GET /pendataans
  # GET /pendataans.json
  def index
    pendataans_scope = Pendataan.includes(:rekening, pendaftaran: [:kecamatan, :kelurahan]).joins(:rekening, pendaftaran: [:kecamatan, :kelurahan]).where('rekenings.kode= ?', @rekening.kode)
    pendataans_scope = pendataans_scope.like(params[:filter]) if params[:filter].present?
    if params[:filter_date].present?
      date = params[:filter_date].split('s/d')
      pendataans_scope = pendataans_scope.where("tgl_data between '" + DateTime.parse(date[0]).strftime("%Y/%m/%d") + "' and '" + DateTime.parse(date[1]).strftime("%Y/%m/%d") + "'")
    end
    @pendaftaran = smart_listing_create(:pendataans, pendataans_scope, partial: "pendataans/listing", default_sort: {"pendataans.created_at": "desc"})
  end

  # GET /pendataans/1
  # GET /pendataans/1.json
  def show
    add_breadcrumb @pendataan.no_pendataan
  end

  # GET /pendataans/new
  def new
    add_breadcrumb 'Buat Baru'
    @pendataan = Pendataan.new
    @pendataan.no_pendataan = generate_no_pendataan
  end

  # GET /pendataans/1/edit
  def edit
    redirect_to @pendataan if @pendataan.penetapan.first.no_setor.present?
    add_breadcrumb 'Edit : ' + @pendataan.no_pendataan
    @pendataan.tgl_data = @pendataan.tgl_data.strftime('%d-%m-%Y')
    @pendataan.periode_awal = @pendataan.periode_awal.strftime('%d-%m-%Y')
    @pendataan.periode_akhir = @pendataan.periode_akhir.strftime('%d-%m-%Y')
    @pendataan.tarif_rupiah = @pendataan.rekening.tarif
    @pendataan.tarif_persen = @pendataan.rekening.persen.to_i
  end

  # POST /pendataans
  # POST /pendataans.json
  def create
    @pendataan = Pendataan.new(pendataan_params)
    @pendataan.no_pendataan = generate_no_pendataan
    if @pendataan.kode_rekening == '1104' or @pendataan.kode_rekening == '1108'
      @pendataan.status = 4
    else
      @pendataan.status = 0
    end
    respond_to do |format|
      if @pendataan.save
        Penetapan.create!(
          pendataan_id:@pendataan.id, 
          pemakaian_daya_teliti:@pendataan.pemakaian_daya,
          volume_pemakaian_teliti:@pendataan.volume_pemakaian,
          jumlah_volume_teliti:@pendataan.jumlah_volume,
          pajak_rokok_teliti:@pendataan.pajak_rokok,
          nilai_reklame_teliti:@pendataan.nilai_reklame,
          npa_teliti:@pendataan.npa,
          omzet_teliti:@pendataan.omzet,
          jumlah_pajak_teliti:@pendataan.jumlah_pajak)
        format.html { redirect_to @pendataan, notice: 'Pendataan berhasil tersimpan.' }
        format.json { render :show, status: :created, location: @pendataan }
      else
        format.html { render :new }
        format.json { render json: @pendataan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pendataans/1
  # PATCH/PUT /pendataans/1.json
  def update
    respond_to do |format|
      if @pendataan.update(pendataan_params)
        format.html { redirect_to @pendataan, notice: 'Pendataan berhasil tersimpan.' }
        format.json { render :show, status: :ok, location: @pendataan }
      else
        format.html { render :edit }
        format.json { render json: @pendataan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pendataans/1
  # DELETE /pendataans/1.json
  def destroy
    @pendataan.destroy
    respond_to do |format|
      format.html { redirect_to pendataans_url, notice: 'Pendataan berhasil terhapus.' }
      format.json { head :no_content }
    end
  end

  def cetak_sptpd
    add_breadcrumb 'Cetak SPTPD'
    @wilayah = Wilayah.first
    @pendataan = Pendataan.find(params[:id])
    @pendataan_sebelumnya = Pendataan.where("pendaftaran_id=" + @pendataan.pendaftaran_id.to_s + " and rekening_id=" + @pendataan.rekening_id.to_s + " and Extract(month from periode_awal)=Extract(month from '" + (@pendataan.periode_awal - 1.month).to_s + "'::date) and Extract(year from periode_awal)=Extract(year from '" + (@pendataan.periode_awal - 1.month).to_s + "'::date)").order('id desc').first
    @rekening_induk = Rekening.where("jenis_kode = '00' and turunan_kode = '00' and kode= '" + @pendataan.rekening.kode + "' and tahun = " + @pendataan.rekening.tahun.to_s).first
    respond_to do |format|
        # format.html
        format.pdf do
          render pdf: 'SPTPD ' + @pendataan.pendaftaran.npwpd + ' ' + I18n.l(@pendataan.periode_awal, format:'%d %B %Y') + ' s/d ' + I18n.l(@pendataan.periode_akhir, format:'%d %B %Y') ,
                 margin:  {
                   top: 5,
                   bottom: 5,
                   left: 5,
                   right: 5
                  },
                disposition: 'attachment'
        end
    end
  end

  def surat_teguran
    add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
    add_breadcrumb 'Cetak Surat Teguran'
    if params[:tgl_data].present?
      @current_date = params[:tgl_data]
    else
      @current_date = Time.now.strftime('%d-%m-%Y')
    end
    teguran_scope = Pendataan.joins(:rekening, pendaftaran: [:kecamatan, :kelurahan]).all
    session[:kode_rekening] = nil
    teguran_scope = teguran_scope.where("extract(year from ((periode_awal + interval '1' month) + interval '14' day)) = extract(year from to_date('" + @current_date + "', 'DD/MM/YYYY')) and extract(month from ((periode_awal + interval '1' month) + interval '14' day)) = extract(month from to_date('" + @current_date + "', 'DD/MM/YYYY'))")
    teguran_scope = teguran_scope.where("pendataans.tgl_setor is null and pendataans.tgl_tetap is null")
    teguran_scope = teguran_scope.where("tahun_spt = ?", params[:filter_tahun_rekening]) if params[:filter_tahun_rekening].present?
    teguran_scope = teguran_scope.where("case when rekenings.kode = '1104' or rekenings.kode = '1108' then tgl_tetap is not null else 1=1 end")
    teguran_scope = teguran_scope.where("rekenings.kode = ?", params[:filter_induk_rekening]) if params[:filter_induk_rekening].present?
    @pendaftaran = smart_listing_create(:tegurans, teguran_scope, partial: "pendataans/listing_teguran", default_sort: {created_at: "desc"})
  end

  def cetak_surat_teguran
    @pendataan = Pendataan.find(params[:id])
    @wilayah = Wilayah.first
    @tgl_cetak = params[:tgl_cetak]
    @perihal = 'Teguran I'
    @jml_hari = ((@pendataan.periode_awal + 13.days + 1.month) - DateTime.parse(@tgl_cetak)).to_i
    @rekening_induk = Rekening.where("tahun=" + @pendataan.rekening.tahun.to_s + " and kode='" + @pendataan.rekening.kode + "' and jenis_kode='00' and turunan_kode='00'").first
    @ttd = Ttd.find(1)
    respond_to do |format|
        # format.html
        format.pdf do
          render pdf: 'Surat_Teguran_' + @pendataan.no_pendataan.to_s + '_' + @tgl_cetak,
                 margin:  {
                   top: 10,
                   bottom: 10,
                   left: 10,
                   right: 10
                  },
               disposition: 'attachment'
        end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pendataan
      @pendataan = Pendataan.friendly.find(params[:id])
      session[:kode_rekening] = Rekening.find(@pendataan.rekening_id).kode
    end

    def set_rekening
      add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
      add_breadcrumb 'Pendataan'.html_safe, pendataans_path(kode_rekening: params[:kode_rekening])
      kode_rekening = ''
      if params[:kode_rekening].present?
        session[:kode_rekening] = params[:kode_rekening]
        kode_rekening = params[:kode_rekening]
      else
        if session[:kode_rekening].present?
          kode_rekening = session[:kode_rekening]
        else
          respond_to do |format|
            format.html { redirect_to root_path, notice: 'session anda expired.' }
          end
          return
        end
      end
      @rekening = Rekening.where("kode = '" + kode_rekening + "' and jenis_kode='00' and turunan_kode='00'").last
    end

    def set_parameter
      params[:pendataan][:omzet] = params[:pendataan][:omzet].gsub('.', '').gsub(',', '.') if params[:pendataan][:omzet].present?
      params[:pendataan][:pemakaian_daya] = params[:pendataan][:pemakaian_daya].gsub('.', '').gsub(',', '.') if params[:pendataan][:pemakaian_daya].present?
      params[:pendataan][:volume_pemakaian] = params[:pendataan][:volume_pemakaian].gsub('.', '').gsub(',', '.') if params[:pendataan][:volume_pemakaian].present?
      params[:pendataan][:jumlah_pajak] = params[:pendataan][:jumlah_pajak].gsub('.', '').gsub(',', '.')
      params[:pendataan][:jumlah_volume] = params[:pendataan][:jumlah_volume].gsub('.', '').gsub(',', '.') if params[:pendataan][:jumlah_volume].present?
      params[:pendataan][:nilai_reklame] = params[:pendataan][:nilai_reklame].gsub('.', '').gsub(',', '.') if params[:pendataan][:nilai_reklame].present?
      params[:pendataan][:npa] = params[:pendataan][:npa].gsub('.', '').gsub(',', '.') if params[:pendataan][:npa].present?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pendataan_params
      params.require(:pendataan).permit(:tgl_data, :tahun_spt, :pendaftaran_id, :rekening_id, :periode_awal, :periode_akhir, :omzet, :jumlah_pajak, :kode_rekening, :tarif_rupiah, :tarif_persen, :filter, :pemakaian_daya, :volume_pemakaian, :jumlah_volume, :filter_tahun_rekening, :filter_induk_rekening, :jenis_surat, :tgl_cetak, :filter_date, :nilai_reklame, :pajak_rokok, :npa)
    end
end
