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
        pendataans_scope = pendataans_scope.where("pendataans.status in (0,1,2)")
        pendataans_scope = pendataans_scope.like(params[:filter]) if params[:filter].present?
        pendataans_scope = pendataans_scope.where("tahun_spt = ?", params[:filter_tahun_rekening]) if params[:filter_tahun_rekening].present?
        pendataans_scope = pendataans_scope.where("rekenings.kode = ?", params[:filter_induk_rekening]) if params[:filter_induk_rekening].present?
        @pendaftaran = smart_listing_create(:pendataans, pendataans_scope, partial: "penyetoran/listing", default_sort: {updated_at: "desc"})
    end

    def proses
        @pendataan = Pendataan.find(params[:id])
        if params[:tanggal].present? and @pendataan.status != 4
            @penetapan = Penetapan.find_by_pendataan_id(@pendataan.id).last
            @penetapan.no_setor = generate_no_setor
            @penetapan.denda = @pendataan.hitung_denda(DateTime.parse(params[:tanggal]))
            @penetapan.tgl_setor = DateTime.parse(params[:tanggal]).strftime('%Y-%m-%d')
            @penetapan.status = @pendataan.status
            @penetapan.save!
            @pendataan.status = 4
            @pendataan.save!
        end
        @wilayah = Wilayah.first
        @ttd = Ttd.find(2)
        respond_to do |format|
            format.pdf do
            render pdf: 'Bukti_Pembayaran_' + @penetapan.no_setor.to_s + '_' + @penetapan.tgl_setor.strftime('%d-%m-%Y'),
                    margin:  {
                        top: 10,
                        bottom: 10,
                        left: 10,
                        right: 10
                    },
                    disposition: 'attachment',
                    template: 'penyetoran/bukti_pembayaran'
            end
        end
    end

    def cetak_tanda_bukti
        @penetapan = Penetapan.find(params[:id])
        @wilayah = Wilayah.first
        @ttd = Ttd.find(2)
        respond_to do |format|
            format.pdf do
            render pdf: 'Bukti_Pembayaran_' + @penetapan.no_setor.to_s + '_' + @penetapan.tgl_setor.strftime('%d-%m-%Y'),
                    margin:  {
                        top: 10,
                        bottom: 10,
                        left: 10,
                        right: 10
                    },
                    disposition: 'attachment',
                    template: 'penyetoran/bukti_pembayaran'
            end
        end
    end

    def list
        pendataan_scope = Penetapan.joins(pendataan: [:rekening, pendaftaran: [:kecamatan, :kelurahan]])
        pendataan_scope = pendataan_scope.where("tgl_setor is not null")
        pendataan_scope = pendataan_scope.like(params[:filter]) if params[:filter].present?
        pendataan_scope = pendataan_scope.where("pendataans.tahun_spt = ?", params[:filter_tahun_rekening]) if params[:filter_tahun_rekening].present?
        pendataan_scope = pendataan_scope.where("rekenings.kode = ?", params[:filter_induk_rekening]) if params[:filter_induk_rekening].present?
        @pendaftaran = smart_listing_create(:pendataans, pendataan_scope, partial: "penyetoran/listing_setor", default_sort: {no_setor: "desc"})
    end

    def cetak_sts
        add_breadcrumb 'Cetak STS'
        respond_to do |format|
            format.pdf do
                @penetapan = Penetapan.all
                if params[:filter_date].present?
                    date = params[:filter_date].split('s/d')
                    @penetapan = @penetapan.where("tgl_setor between '" + DateTime.parse(date[0]).strftime("%Y/%m/%d") + "' and '" + DateTime.parse(date[1]).strftime("%Y/%m/%d") + "' and tgl_setor is not null")
                end
                @wilayah = Wilayah.first
                @ttd = Ttd.find(4)
                # @rekening_induk = Rekening.where("tahun=" + @penetapan.pendataan.rekening.tahun.to_s + " and kode='" + @penetapan.pendataan.rekening.kode + "' and jenis_kode='00' and turunan_kode='00'").first
                render pdf: 'STS_' + (params[:filter_date] if params[:filter_date].present?),
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
