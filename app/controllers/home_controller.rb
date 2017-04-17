class HomeController < ApplicationController
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  def index
    add_breadcrumb 'Dashboard'
    @pendaftaran = Pendaftaran.all
    @pendataan = Pendataan.joins(:rekening).where("tahun_spt=" + Time.now.year.to_s).all
  end
end
