class PendaftaransController < ApplicationController
  before_action :set_pendaftaran, only: [:show, :edit, :update, :destroy]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  add_breadcrumb 'Pendaftaran'.html_safe, :pendaftarans_path
  include ApplicationHelper

  # GET /pendaftarans
  # GET /pendaftarans.json
  def index
    pendaftaran_scope = Pendaftaran.includes(:kecamatan, :kelurahan).all
    if params[:filter_date].present?
      date = params[:filter_date].split('s/d')
      pendaftaran_scope = pendaftaran_scope.where("tgl_daftar between '" + DateTime.parse(date[0]).strftime("%Y/%m/%d") + "' and '" + DateTime.parse(date[1]).strftime("%Y/%m/%d") + "'")
    end
    pendaftaran_scope = pendaftaran_scope.where("kecamatan_id= " + params[:filter_kecamatan]) if params[:filter_kecamatan].present?
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
    no_pendaftaran = generate_no_pendaftaran
    npwpd = @pendaftaran.npwpd
    @pendaftaran.no_pendaftaran = no_pendaftaran
    @pendaftaran.no_reg_pendaftaran = no_pendaftaran + '/' + Date.today.year.to_s
    @pendaftaran.npwpd = npwpd[0..3] + no_pendaftaran + '.' + Kecamatan.find(@pendaftaran.kecamatan_id).kode + '.' + Kelurahan.find(@pendaftaran.kelurahan_id).kode
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
    respond_to do |format|
        format.html
        format.pdf do
          pendaftaran_scope = Pendaftaran.all
          judul = "Daftar Wajib Pajak "
          if params[:filter_date].present?
            judul += params[:filter_date]
            date = params[:filter_date].split('s/d')
            pendaftaran_scope = pendaftaran_scope.where("tgl_daftar between '" + DateTime.parse(date[0]).strftime("%Y/%m/%d") + "' and '" + DateTime.parse(date[1]).strftime("%Y/%m/%d") + "'")
          end
          if params[:filter_kecamatan].present?
            judul += ' ' + Kecamatan.find(params[:filter_kecamatan]).nama
            pendaftaran_scope = pendaftaran_scope.where("kecamatan_id= " + params[:filter_kecamatan])
          end
          pendaftaran_scope = pendaftaran_scope.where("status= ?", Pendaftaran.statuses[params[:status]]) if params[:status].present?
          @pendaftaran = pendaftaran_scope
          @wilayah = Wilayah.first
          @tanggal = params[:filter_date]
          render pdf: judul,
                  disposition: 'attachment',
                  page_size: 'Legal'
        end
    end
  end

  def cetak_npwpd
    add_breadcrumb 'Cetak Kartu NPWPD'
    respond_to do |format|
        format.html
        format.pdf do
          pendaftaran_scope = Pendaftaran.all
          judul = "NPWPD "
          if params[:filter_kecamatan].present?
            judul += ' ' + Kecamatan.find(params[:filter_kecamatan]).nama
            pendaftaran_scope = pendaftaran_scope.where("kecamatan_id= " + params[:filter_kecamatan])
          end
          if params[:no_pendaftaran].present? and params[:no_pendaftaran2].present?
            pendaftaran_scope = pendaftaran_scope.where("no_pendaftaran::int between '" + params[:no_pendaftaran] + "'::int and '" + params[:no_pendaftaran2] + "'::int")
            judul += ' No Pendaftaran' + params[:no_pendaftaran].to_s + ' s/d ' + params[:no_pendaftaran2]
          elsif params[:no_pendaftaran].present? and !params[:no_pendaftaran2].present?
            pendaftaran_scope = pendaftaran_scope.where("no_pendaftaran::int = '" + params[:no_pendaftaran] + "'::int")
            judul += ' No Pendaftaran' + params[:no_pendaftaran].to_s
          elsif !params[:no_pendaftaran].present? and params[:no_pendaftaran2].present?
            pendaftaran_scope = pendaftaran_scope.where("no_pendaftaran::int = '" + params[:no_pendaftaran2] + "'::int")
            judul += ' No Pendaftaran' + params[:no_pendaftaran2]
          end
          @pendaftaran = pendaftaran_scope
          @wilayah = Wilayah.first
          render pdf: judul,
                  margin:  {
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0
                    },
                  disposition: 'attachment',
                  page_height: '2.20472in', 
                  page_width: '3.50394in'
        end
    end
  end

  def cetak_kartu_data
    add_breadcrumb 'Cetak Kartu Data'
    respond_to do |format|
        format.html
        format.pdf do
          pendaftaran_scope = Pendataan.select('tahun_spt, pendaftaran_id, rekening_id').distinct.joins(:rekening, :pendaftaran).all
          judul = "Kartu Data "
          if params[:filter_tahun_rekening].present?
            judul += ' Tahun ' + params[:filter_tahun_rekening].to_s
            pendaftaran_scope = pendaftaran_scope.where("rekenings.tahun= " + params[:filter_tahun_rekening])
          end
          if params[:filter_induk_rekening].present?
            judul += ' Rekening ' + Kecamatan.find_by_kode(params[:filter_induk_rekening]).nama_rekening
            pendaftaran_scope = pendaftaran_scope.where("rekenings.kode= '" + params[:filter_induk_rekening] + "'")
          end
          if params[:no_pendaftaran].present? and params[:no_pendaftaran2].present?
            pendaftaran_scope = pendaftaran_scope.where("no_pendaftaran::int between '" + params[:no_pendaftaran] + "'::int and '" + params[:no_pendaftaran2] + "'::int")
            judul += ' No Pendaftaran' + params[:no_pendaftaran].to_s + ' s/d ' + params[:no_pendaftaran2]
          elsif params[:no_pendaftaran].present? and !params[:no_pendaftaran2].present?
            pendaftaran_scope = pendaftaran_scope.where("no_pendaftaran::int = '" + params[:no_pendaftaran] + "'::int")
            judul += ' No Pendaftaran' + params[:no_pendaftaran].to_s
          elsif !params[:no_pendaftaran].present? and params[:no_pendaftaran2].present?
            pendaftaran_scope = pendaftaran_scope.where("no_pendaftaran::int = '" + params[:no_pendaftaran2] + "'::int")
            judul += ' No Pendaftaran' + params[:no_pendaftaran2]
          end
          @pendaftaran = pendaftaran_scope
          @wilayah = Wilayah.first
          render pdf: judul,
                  margin:  {
                        top: 10,
                        bottom: 10,
                        left: 10,
                        right: 10
                    },
                  disposition: 'attachment', 
                  page_size: 'Legal'
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
      params.require(:pendaftaran).permit(:no_pendaftaran, :no_pendaftaran2, :nama_usaha, :alamat_usaha, :kecamatan_id, :kelurahan_id, :no_telp_usaha, :nama_pemilik, :alamat_pemilik, :no_telp_pemilik, :npwpd, :tgl_npwpd, :usaha_id, :filter, :no_reg_pendaftaran, :tgl_daftar, :filter_date, :filter, :filter_kecamatan, :status, :filter_tahun_rekening, :filter_induk_rekening, :npwp)
    end
end
