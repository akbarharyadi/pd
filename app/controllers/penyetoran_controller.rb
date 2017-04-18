class PenyetoranController < ApplicationController
    include SmartListing::Helper::ControllerExtensions
    add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
    add_breadcrumb 'Penyetoran'
    helper  SmartListing::Helper
    include ApplicationHelper
    def index
        if params[:tanggal].present?
            @current_date = params[:tanggal]
        else
            @current_date = Time.now.strftime('%d-%m-%Y')
        end
        pendataans_scope = Pendataan.joins(:rekening, pendaftaran: [:kecamatan, :kelurahan])
        pendataans_scope = pendataans_scope.where("tgl_setor is null")
        pendataans_scope = pendataans_scope.where("case when rekenings.kode = '1104' or rekenings.kode = '1108' then tgl_tetap is not null else 1=1 end")
        pendataans_scope = pendataans_scope.like(params[:filter]) if params[:filter].present?
        pendataans_scope = pendataans_scope.where("tahun_spt = ?", params[:filter_tahun_rekening]) if params[:filter_tahun_rekening].present?
        pendataans_scope = pendataans_scope.where("rekenings.kode = ?", params[:filter_induk_rekening]) if params[:filter_induk_rekening].present?
        @pendaftaran = smart_listing_create(:pendataans, pendataans_scope, partial: "penyetoran/listing", default_sort: {created_at: "desc"})
    end

    def proses
        @pendataan = Pendataan.find(params[:id])
        if params[:tanggal].present? and !@pendataan.tgl_setor.present?
            @pendataan.no_setor = generate_no_setor
            @pendataan.kode_rekening = @pendataan.rekening.kode
            @pendataan.denda = @pendataan.hitung_denda(DateTime.parse(params[:tanggal]))
            @pendataan.tgl_setor = DateTime.parse(params[:tanggal]).strftime('%Y-%m-%d')
            @pendataan.save!
        end
        @wilayah = Wilayah.first
        @ttd = Ttd.find(2)
        respond_to do |format|
            format.pdf do
            render pdf: 'Bukti_Pembayaran_' + @pendataan.no_setor.to_s + '_' + @pendataan.tgl_setor.strftime('%d-%m-%Y'),
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

    def list
        pendataans_scope = Pendataan.joins(:rekening, pendaftaran: [:kecamatan, :kelurahan])
        pendataans_scope = pendataans_scope.where("tgl_setor is not null")
        pendataans_scope = pendataans_scope.like(params[:filter]) if params[:filter].present?
        pendataans_scope = pendataans_scope.where("tahun_spt = ?", params[:filter_tahun_rekening]) if params[:filter_tahun_rekening].present?
        pendataans_scope = pendataans_scope.where("rekenings.kode = ?", params[:filter_induk_rekening]) if params[:filter_induk_rekening].present?
        @pendaftaran = smart_listing_create(:pendataans, pendataans_scope, partial: "penyetoran/listing_setor", default_sort: {no_setor: "desc"})
    end

    def cetak_sts
        add_breadcrumb 'Cetak STS'
        pendataans_scope = Pendataan.joins(:rekening, pendaftaran: [:kecamatan, :kelurahan])
        if params[:tanggal].present?
            pendataans_scope = pendataans_scope.where("tgl_setor='" + DateTime.parse(params[:tanggal]).strftime('%Y-%m-%d') + "'")
        else
            pendataans_scope = pendataans_scope.where("no_setor=0")
        end
        @pendataan = smart_listing_create(:pendataans, pendataans_scope, partial: "penyetoran/listing_sts", default_sort: {no_setor: "desc"})
        respond_to do |format|
            format.pdf do
                @pendataan = Pendataan.find(params[:id])
                @wilayah = Wilayah.first
                @ttd = Ttd.find(4)
                @rekening_induk = Rekening.where("tahun=" + @pendataan.rekening.tahun.to_s + " and kode='" + @pendataan.rekening.kode + "' and jenis_kode='00' and turunan_kode='00'").first
                render pdf: 'STS_' + @pendataan.tgl_setor.strftime('%Y-%m-%d'),
                    margin:  {
                        top: 10,
                        bottom: 10,
                        left: 10,
                        right: 10
                    },
                    disposition: 'attachment', :page_height => '7.5in', :page_width => '8.3in'
            end
            format.html do
                @pendataan
            end
            format.js do
                @pendataan
            end
        end
    end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
        def penyetoran_params
            params.permit(:filter_tahun_rekening, :filter_induk_rekening, :tanggal, :filter, :id)
        end
end
