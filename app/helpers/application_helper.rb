module ApplicationHelper
  def generate_no_pendaftaran
    pendaftaran = Pendaftaran.order("no_pendaftaran::int desc").first
    if pendaftaran == nil
        1.to_s.rjust(7, '0')
    else
        (pendaftaran.no_pendaftaran.to_i + 1).to_s.rjust(7, '0')
    end
  end

  def generate_no_pendataan
    pendataan = Pendataan.order("no_pendataan::int desc").first
    if pendataan == nil
        1.to_s.rjust(7, '0')
    else
        (pendataan.no_pendataan.to_i + 1).to_s.rjust(7, '0')
    end
  end
end
