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

  def generate_no_pendataan
    pendataan = Pendataan.order("no_pendataan::int desc").first
    if pendataan == nil
        1.to_s.rjust(7, '0')
    else
        (pendataan.no_pendataan.to_i + 1).to_s.rjust(7, '0')
    end
  end

  def generate_no_setor
    pendataan = Pendataan.where("no_setor is not null").order("no_setor::int desc").first
    if pendataan == nil
        1
    else
        pendataan.no_setor + 1
    end
  end

  def generate_no_kohir
    pendataan = Pendataan.where("no_kohir is not null").order("no_kohir::int desc").first
    if pendataan == nil
        1
    else
        pendataan.no_kohir + 1
    end
  end
end
