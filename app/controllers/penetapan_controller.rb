class PenetapanController < ApplicationController
    before_action :set_parameter, only: [:tetapkan]
    include SmartListing::Helper::ControllerExtensions
    add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
    add_breadcrumb 'Penetapan'
    helper  SmartListing::Helper
    include ApplicationHelper
    def index
        @current_date = Time.now.strftime('%d-%m-%Y')
        respond_to do |format|
            format.html
            format.js do
                @pendataan = Pendataan.joins(:rekening, pendaftaran: [:kecamatan, :kelurahan]).where("pendataans.no_pendataan = '" + params[:no_pendataan_penetapan] + "'")
                @pendataan = @pendataan.where("case when rekenings.kode in ('1104', '1108') then pendataans.status in (3,4) else (((periode_awal + interval '1' month) + interval '14' day) < to_date('" + @current_date + "', 'DD/MM/YYYY') and pendataans.status = 0) or pendataans.status in (3,4)  end").take
                if @pendataan.present?
                    @pendataan.tgl_data = @pendataan.tgl_data.strftime('%d-%m-%Y')
                    @pendataan.periode_awal = @pendataan.periode_awal.strftime('%d-%m-%Y')
                    @pendataan.periode_akhir = @pendataan.periode_akhir.strftime('%d-%m-%Y')
                    @pendataan.tarif_rupiah = @pendataan.rekening.tarif
                    @pendataan.tarif_persen = @pendataan.rekening.persen.to_i
                    if @pendataan.penetapan.last.no_setor.present?
                        @jenis_skp = 'SKPDN'
                    else
                        @jenis_skp = 'SKPD'
                    end
                end
            end
        end
    end

    def tetapkan
        penetapan = Penetapan.find(params[:penetapan][:id])
        params[:penetapan][:no_tetap] = generate_no_kohir
        respond_to do |format|
            if penetapan.update(penetapan_params)
                pendataan = Pendataan.find(penetapan.pendataan_id)
                pendataan.kode_rekening = pendataan.rekening.kode
                if params[:skp] = 'SKPD'
                    pendataan.status = 1
                elsif params[:skp] = 'SKPDN'
                    pendataan.status = 3
                elsif params[:skp] = 'SKPDKB'
                    pendataan.status = 2
                end
                pendataan.save!
                format.html { redirect_to penetapan_index_path, notice: 'Data dengan no kohir : ' + penetapan.no_tetap.to_s + ' berhasil ditetapkan.' }
            else
                format.html { redirect_to penetapan_index_path, notice: 'Penetapan gagal dilakuan' }
            end
        end
    end

    def proses
        @pendataan = Pendataan.find(params[:id])
        @pendataan.tgl_tetap = DateTime.parse(params[:tanggal]).strftime('%Y-%m-%d')
        @pendataan.no_kohir = generate_no_kohir
        @pendataan.kode_rekening = @pendataan.rekening.kode
        @pendataan.denda = @pendataan.hitung_denda(@pendataan.tgl_tetap) unless @pendataan.tgl_setor.present?
        respond_to do |format|
            if @pendataan.save
                format.html { redirect_to penetapan_index_path, notice: 'Data dengan no pendataan : ' + pendataan.no_pendataan + ' berhasil ditetapkan.' }
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
        @pendataan.denda = @pendataan.hitung_denda(tgl_cetak) unless @pendataan.tgl_setor.present?
        @pendataan.tgl_cetak_skp = tgl_cetak.strftime('%Y-%m-%d') unless @pendataan.tgl_setor.present?
        judul = 'SKPD_'
        judul += 'NIHIL_' if @pendataan.tgl_setor.present?
        judul += 'No_' + @pendataan.no_kohir.to_s + Time.now.to_s
        @pendataan.save
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

        def set_parameter
            params[:penetapan][:omzet_teliti] = params[:penetapan][:omzet_teliti].gsub('.', '').gsub(',', '.') if params[:penetapan][:omzet_teliti].present?
            params[:penetapan][:pemakaian_daya_teliti] = params[:penetapan][:pemakaian_daya_teliti].gsub('.', '').gsub(',', '.') if params[:penetapan][:pemakaian_daya_teliti].present?
            params[:penetapan][:volume_pemakaian_teliti] = params[:penetapan][:volume_pemakaian_teliti].gsub('.', '').gsub(',', '.') if params[:penetapan][:volume_pemakaian_teliti].present?
            params[:penetapan][:jumlah_pajak_teliti] = params[:penetapan][:jumlah_pajak_teliti].gsub('.', '').gsub(',', '.') if params[:penetapan][:jumlah_pajak_teliti].present?
            params[:penetapan][:jumlah_volume_teliti] = params[:penetapan][:jumlah_volume_teliti].gsub('.', '').gsub(',', '.') if params[:penetapan][:jumlah_volume_teliti].present?
            params[:penetapan][:nilai_reklame_teliti] = params[:penetapan][:nilai_reklame_teliti].gsub('.', '').gsub(',', '.') if params[:penetapan][:nilai_reklame_teliti].present?
            params[:penetapan][:npa_teliti] = params[:penetapan][:npa_teliti].gsub('.', '').gsub(',', '.') if params[:penetapan][:npa_teliti].present?
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def penetapan_params
            params.require(:penetapan).permit(:no_tetap, :skp, :hasil_penetapan, :tgl_tetap, :filter_tahun_rekening, :filter_induk_rekening, :tanggal, :filter, :id, :no_pendataan_penetapan, :npa_teliti, :nilai_reklame_teliti, :jumlah_volume_teliti, :volume_pemakaian_teliti, :pemakaian_daya_teliti, :omzet_teliti, :jumlah_pajak_teliti)
        end
end
