class Kelurahan < ApplicationRecord
    include Auditable
    belongs_to :kecamatan
    has_many :pendaftaran

    #validasi Kelurahan
    validates :kecamatan_id, :kode, :nama, presence: true
    
    #Validasi kode
    validates_uniqueness_of :kode, :scope => :kecamatan_id
    validates :kode, length: { minimum:2 }

    #slugger
    extend FriendlyId
    friendly_id :nama, use: :slugged

    #scope untuk filter like
    scope :like, ->(args) { where("trim(upper(kode)) like trim(upper('%#{args}%')) or trim(upper(nama)) like trim(upper('%#{args}%'))")}

    #humanize title
    HUMANIZED_ATTRIBUTES = {
        :kecamatan_id => "Kecamatan",
        :kode => "Kode Kelurahan/Desa",
        :nama => "Nama Kelurahan/Desa"
    }
    def self.human_attribute_name(attr, error = nil)
        HUMANIZED_ATTRIBUTES[attr.to_sym] || super
    end

    def kode_dan_kelurahan
        "#{kode} - #{nama}"
    end

end
