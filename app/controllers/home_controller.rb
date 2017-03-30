class HomeController < ApplicationController
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  def index
    add_breadcrumb 'Dashboard'
    @pendaftaran = Pendaftaran.last(10)
  end
end
