class PenetapanController < ApplicationController
    include SmartListing::Helper::ControllerExtensions
    add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
    add_breadcrumb 'Penetapan'
    helper  SmartListing::Helper
    include ApplicationHelper
    def index
        if params[:tanggal].present?
            @current_date = params[:tanggal]
        else
            @current_date = Time.now.strftime('%d-%m-%Y')
        end
        pendataans_scope = Pendataan.joins(:rekening, pendaftaran: [:kecamatan, :kelurahan])
        pendataans_scope = pendataans_scope.where('tgl_tetap is null')
        pendataans_scope = pendataans_scope.where("case when rekenings.kode = '1104' or rekenings.kode = '1108' then tgl_tetap is null else to_date('15/'||extract(month from ((periode_awal + interval '1' month) + interval '14' day))::text||'/'||extract(year from ((periode_awal + interval '1' month) + interval '14' day))::text, 'DD/MM/YYYY') <= to_date('#{@current_date}', 'DD/MM/YYYY') or tgl_setor is not null end")
        pendataans_scope = pendataans_scope.like(params[:filter]) if params[:filter].present?
        pendataans_scope = pendataans_scope.where("tahun_spt = ?", params[:filter_tahun_rekening]) if params[:filter_tahun_rekening].present?
        pendataans_scope = pendataans_scope.where("rekenings.kode = ?", params[:filter_induk_rekening]) if params[:filter_induk_rekening].present?
        @pendaftaran = smart_listing_create(:pendataans, pendataans_scope, partial: "penetapan/listing", default_sort: {created_at: "desc"})
    end

    def proses
        @pendataan = Pendataan.find(params[:id])
        @pendataan.tgl_tetap = DateTime.parse(params[:tanggal]).strftime('%Y-%m-%d')
        @pendataan.no_kohir = generate_no_kohir
        @pendataan.kode_rekening = @pendataan.rekening.kode
        respond_to do |format|
            if @pendataan.save
                format.html { redirect_to penetapan_index_path, notice: 'Data dengan no pendataan : ' + @pendataan.no_pendataan + ' berhasil ditetapkan.' }
            else
                format.html { redirect_to penetapan_index_path, notice: 'Penetapan gagal dilakuan' }
            end
        end
    end

    def list
        if params[:tanggal].present?
            @current_date = params[:tanggal]
        else
            @current_date = Time.now.strftime('%d-%m-%Y')
        end
        pendataans_scope = Pendataan.joins(:rekening, pendaftaran: [:kecamatan, :kelurahan])
        pendataans_scope = pendataans_scope.where('tgl_tetap is not null')
        pendataans_scope = pendataans_scope.like(params[:filter]) if params[:filter].present?
        pendataans_scope = pendataans_scope.where("tahun_spt = ?", params[:filter_tahun_rekening]) if params[:filter_tahun_rekening].present?
        pendataans_scope = pendataans_scope.where("rekenings.kode = ?", params[:filter_induk_rekening]) if params[:filter_induk_rekening].present?
        @pendaftaran = smart_listing_create(:pendataans, pendataans_scope, partial: "penetapan/listing_tetap", default_sort: {no_setor: "desc"})
    end

    def cetak_skp
        tgl_cetak = DateTime.parse(params[:tanggal])
        @wilayah = Wilayah.first
        @pendataan = Pendataan.find(params[:id])
        @rekening_induk = Rekening.where("jenis_kode = '00' and turunan_kode = '00' and kode= '" + @pendataan.rekening.kode + "' and tahun = " + @pendataan.rekening.tahun.to_s).first
        @ttd = Ttd.find(3)
        @pendataan.denda = @pendataan.hitung_denda(@pendataan.tgl_tetap) if !@pendataan.tgl_setor.present?
        @pendataan.tgl_cetak_skp = tgl_cetak.strftime('%Y-%m-%d') if !@pendataan.tgl_cetak_skp.present?
        judul = 'SKPD_'
        judul += 'NIHIL_' if @pendataan.tgl_setor.present?
        judul += 'No_' + @pendataan.no_kohir.to_s + Time.now.to_s
        respond_to do |format|
            # format.html
            format.pdf do
            render pdf: judul,
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

    private
        # Never trust parameters from the scary internet, only allow the white list through.
        def penyetoran_params
            params.permit(:filter_tahun_rekening, :filter_induk_rekening, :tanggal, :filter, :id)
        end
end
