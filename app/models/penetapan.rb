class Penetapan < ApplicationRecord
    belongs_to :pendataan

    attr_accessor :tarif_persen_teliti, :tarif_rupiah_teliti
end
