class RekeningsController < ApplicationController
  before_action :set_rekening, only: [:show, :edit, :update, :destroy]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  add_breadcrumb '<i class="ace-icon fa fa-home home-icon"></i> Home'.html_safe, :root_path
  add_breadcrumb ' Index Rekening'.html_safe, :rekenings_path
  # GET /rekenings
  # GET /rekenings.json
  def index
    rekening_scope = Rekening.all
    rekening_scope = rekening_scope.like(params[:filter]) if params[:filter]
    @rekening = smart_listing_create(:rekenings, rekening_scope, partial: "rekenings/listing", default_sort: {kode: "asc"})
  end

  # GET /rekenings/1
  # GET /rekenings/1.json
  def show
  end

  # GET /rekenings/new
  def new
    add_breadcrumb 'Buat Baru'
    @rekening = Rekening.new
  end

  # GET /rekenings/1/edit
  def edit
  end

  # POST /rekenings
  # POST /rekenings.json
  def create
    @rekening = Rekening.new(rekening_params)

    respond_to do |format|
      if @rekening.save
        format.html { redirect_to @rekening, notice: 'Rekening was successfully created.' }
        format.json { render :show, status: :created, location: @rekening }
      else
        format.html { render :new }
        format.json { render json: @rekening.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rekenings/1
  # PATCH/PUT /rekenings/1.json
  def update
    respond_to do |format|
      if @rekening.update(rekening_params)
        format.html { redirect_to @rekening, notice: 'Rekening was successfully updated.' }
        format.json { render :show, status: :ok, location: @rekening }
      else
        format.html { render :edit }
        format.json { render json: @rekening.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rekenings/1
  # DELETE /rekenings/1.json
  def destroy
    @rekening.destroy
    respond_to do |format|
      format.html { redirect_to rekenings_url, notice: 'Rekening was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rekening
      @rekening = Rekening.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rekening_params
      params.require(:rekening).permit(:kode, :jenis_kode, :turunan_kode, :tahun, :tarif, :persen, :nama_rekening)
    end
end
