module ApplicationHelper
  def generate_no_pendaftaran
    pendaftaran = Pendaftaran.order("no_pendaftaran::int desc").first
    if pendaftaran == nil
        1.to_s.rjust(7, '0')
    else
        (pendaftaran.no_pendaftaran.to_i + 1).to_s.rjust(7, '0')
    end
  end
end
