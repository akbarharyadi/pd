class Pendataan < ApplicationRecord
    extend FriendlyId
    
    friendly_id :no_pendataan, use: :slugged
    belongs_to :pendaftaran
    belongs_to :rekening

    validates :tgl_data, :tahun_spt, :pendaftaran_id, :rekening_id, :periode_awal, :periode_akhir, :jumlah_pajak, :no_pendataan, presence: true
    validates :no_pendataan, uniqueness: true
    validate :massa_pajak, :on => :create, if: "self.kode_rekening != '1104'" 
    validate :massa_pajak_update, :on => :update, if: "self.kode_rekening != '1104'" 
    validates :pemakaian_daya, :volume_pemakaian, presence: true, if: "self.kode_rekening == '1105'"
    validates :omzet, presence: true, if: "self.kode_rekening != '1105' and self.kode_rekening != '1111' and self.kode_rekening != '1104' and self.kode_rekening != '1108'"
    validates :jumlah_volume, presence: true, if: "self.kode_rekening == '1111'"
    validates :nilai_reklame, presence: true, if: "self.kode_rekening == '1104'"
    validates :npa, presence: true, if: "self.kode_rekening == '1108'"
    acts_as_paranoid

    attr_accessor :tarif_persen, :tarif_rupiah, :kode_rekening

    scope :like, ->(args) { where("pendataans.tahun_spt::text= '#{args}' or pendataans.no_pendataan= '#{args}' or trim(upper(rekenings.nama_rekening)) like trim(upper('%#{args}%')) or trim(upper(pendaftarans.npwpd)) like trim(upper('%#{args}%')) or trim(upper(pendaftarans.nama_usaha)) like trim(upper('%#{args}%'))")}
    def massa_pajak
        if self.tahun_spt.present? and self.rekening_id.present? and self.periode_awal.present? 
            @pendataan = Pendataan.where("pendaftaran_id=" + self.pendaftaran_id.to_s + " and tahun_spt=" + self.tahun_spt.to_s + " and rekening_id=" + self.rekening_id.to_s + " and Extract(month from periode_awal)=Extract(month from '" + self.periode_awal.to_s + "'::date) and Extract(year from periode_awal)=Extract(year from '" + self.periode_awal.to_s + "'::date)")
            if @pendataan.present?
                errors.add(:periode_awal, " masa pajak yang anda pilih sudah ada.")
            else
                true
            end   
        else
            true
        end
    end

    def massa_pajak_update
        if self.tahun_spt.present? and self.rekening_id.present? and self.periode_awal.present? 
            @pendataan = Pendataan.where("pendaftaran_id=" + self.pendaftaran_id.to_s + " and tahun_spt=" + self.tahun_spt.to_s + " and rekening_id=" + self.rekening_id.to_s + " and Extract(month from periode_awal)=Extract(month from '" + self.periode_awal.to_s + "'::date) and Extract(year from periode_awal)=Extract(year from '" + self.periode_awal.to_s + "'::date) and id !=" + self.id.to_s)
            if @pendataan.present?
                errors.add(:periode_awal, "/ masa pajak yang anda pilih sudah ada.")
            else
                true
            end   
        else
            true
        end
    end

    def jatuh_tempo
        if self.rekening.kode == '1104' or self.rekening.kode == '1108'
            if self.tgl_tetap.present?
                self.tgl_tetap + 15.days
            else
                '-'
            end
        else
            if self.periode_awal.day > 1
                DateTime.parse(self.periode_awal.year.to_s + '-' + self.periode_awal.month.to_s + '-15') + 1.months
            else
                self.periode_awal + 14.days + 1.months
            end
        end
    end

    def status_pendataan
        if self.rekening.kode == '1104' and !self.tgl_tetap.present?
                'Belum Penetapan'
        else
            if !self.tgl_setor.present? and self.jatuh_tempo > Time.now
                'Belum Bayar'
            elsif self.jatuh_tempo < Time.now and !self.tgl_setor.present? and !self.tgl_tetap.present?
                'Jatuh Tempo'
            elsif self.rekening.kode == '1104' and  self.jatuh_tempo < Time.now and !self.tgl_setor.present?
                'Jatuh Tempo'
            elsif self.tgl_tetap.present? and !self.tgl_setor.present? 
                'SKPD (Belum Bayar)'
            else
                'Lunas'
            end
        end
    end

    def status_penyetoran_dari
        if self.tgl_tetap.present?
            "SKPD"
        else
            "SPTPD"
        end
    end

    def hitung_denda(tgl_tetap)
        if self.jatuh_tempo <= tgl_tetap
            (((tgl_cetak.year - self.jatuh_tempo.year) * 12) + tgl_cetak.month - self.jatuh_tempo.month + (tgl_cetak.day < self.jatuh_tempo.day ? 0 : 1)) * 0.02 * self.jumlah_pajak
        else
            0
        end
    end 

end
