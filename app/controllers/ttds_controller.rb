class TtdsController < ApplicationController
  before_action :set_ttd, only: [:show, :edit, :update, :destroy]

  # GET /ttds
  # GET /ttds.json
  def index
    @ttds = Ttd.all
  end

  # GET /ttds/1
  # GET /ttds/1.json
  def show
  end

  # GET /ttds/new
  def new
    @ttd = Ttd.new
  end

  # GET /ttds/1/edit
  def edit
  end

  # POST /ttds
  # POST /ttds.json
  def create
    @ttd = Ttd.new(ttd_params)

    respond_to do |format|
      if @ttd.save
        format.html { redirect_to @ttd, notice: 'Ttd was successfully created.' }
        format.json { render :show, status: :created, location: @ttd }
      else
        format.html { render :new }
        format.json { render json: @ttd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ttds/1
  # PATCH/PUT /ttds/1.json
  def update
    respond_to do |format|
      if @ttd.update(ttd_params)
        format.html { redirect_to @ttd, notice: 'Ttd was successfully updated.' }
        format.json { render :show, status: :ok, location: @ttd }
      else
        format.html { render :edit }
        format.json { render json: @ttd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ttds/1
  # DELETE /ttds/1.json
  def destroy
    @ttd.destroy
    respond_to do |format|
      format.html { redirect_to ttds_url, notice: 'Ttd was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ttd
      @ttd = Ttd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ttd_params
      params.require(:ttd).permit(:baris1, :baris2, :baris3, :pegawai_id)
    end
end
