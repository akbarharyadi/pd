class JabatansController < ApplicationController
  before_action :set_jabatan, only: [:show, :edit, :update, :destroy]

  # GET /jabatans
  # GET /jabatans.json
  def index
    @jabatans = Jabatan.all
  end

  # GET /jabatans/1
  # GET /jabatans/1.json
  def show
  end

  # GET /jabatans/new
  def new
    @jabatan = Jabatan.new
  end

  # GET /jabatans/1/edit
  def edit
  end

  # POST /jabatans
  # POST /jabatans.json
  def create
    @jabatan = Jabatan.new(jabatan_params)

    respond_to do |format|
      if @jabatan.save
        format.html { redirect_to @jabatan, notice: 'Jabatan was successfully created.' }
        format.json { render :show, status: :created, location: @jabatan }
      else
        format.html { render :new }
        format.json { render json: @jabatan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jabatans/1
  # PATCH/PUT /jabatans/1.json
  def update
    respond_to do |format|
      if @jabatan.update(jabatan_params)
        format.html { redirect_to @jabatan, notice: 'Jabatan was successfully updated.' }
        format.json { render :show, status: :ok, location: @jabatan }
      else
        format.html { render :edit }
        format.json { render json: @jabatan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jabatans/1
  # DELETE /jabatans/1.json
  def destroy
    @jabatan.destroy
    respond_to do |format|
      format.html { redirect_to jabatans_url, notice: 'Jabatan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jabatan
      @jabatan = Jabatan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jabatan_params
      params.require(:jabatan).permit(:kode_jabatan, :nama_jabatan, :singkatan)
    end
end
