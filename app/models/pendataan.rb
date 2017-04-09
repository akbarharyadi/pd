class Pendataan < ApplicationRecord
    extend FriendlyId
    friendly_id :no_pendataan, use: :slugged
    belongs_to :pendaftaran
    belongs_to :rekening

    validates :tgl_data, :tahun_spt, :pendaftaran_id, :rekening_id, :periode_awal, :periode_akhir, :jumlah_pajak, :no_pendataan, presence: true
    validates :no_pendataan, uniqueness: true
    validate :massa_pajak, :on => :create
    validate :massa_pajak_update, :on => :update
    validates :pemakaian_daya, :volume_pemakaian, presence: true, if: "self.kode_rekening == '1105'"
    validates :omzet, presence: true, if: "self.kode_rekening != '1105' and self.kode_rekening != '1111'"
    validates :jumlah_volume, presence: true, if: "self.kode_rekening == '1111'"
    acts_as_paranoid

    attr_accessor :tarif_persen, :tarif_rupiah, :kode_rekening

    scope :like, ->(args) { where("pendataans.tahun_spt::text= '#{args}' or pendataans.no_pendataan= '#{args}' or trim(upper(rekenings.nama_rekening)) like trim(upper('%#{args}%')) or trim(upper(pendaftarans.npwpd)) like trim(upper('%#{args}%')) or trim(upper(pendaftarans.nama_usaha)) like trim(upper('%#{args}%'))")}

    def massa_pajak
        if self.tahun_spt.present? and self.rekening_id.present? and self.periode_awal.present? 
            @pendataan = Pendataan.where("pendaftaran_id=" + self.pendaftaran_id.to_s + " and tahun_spt=" + self.tahun_spt.to_s + " and rekening_id=" + self.rekening_id.to_s + " and Extract(month from periode_awal)=Extract(month from '" + self.periode_awal.to_s + "'::date) and Extract(year from periode_awal)=Extract(year from '" + self.periode_awal.to_s + "'::date)")
            if @pendataan.present?
                errors.add(:periode_awal, "/ masa pajak yang anda pilih sudah ada.")
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

end
