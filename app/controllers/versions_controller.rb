class VersionsController < ApplicationController
  before_action :set_version, only: [:show, :update, :destroy]
  before_action :set_project, only: [:index, :create]
  before_action :authenticate_and_set_user, except: [:show, :index]

  # GET /projects/1/versions
  def index
    @versions = @project.page(@page).per(@per)

    render json: @versions
  end

  # GET /versions/1
  def show
    render json: @version
  end

  # POST /projects/1/versions
  def create
    @version = Version.new(version_params)

    if @version.save
      render json: @version, status: :created, location: @version
    else
      render json: @version.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /versions/1
  def update
    if @version.update(version_params)
      render json: @version
    else
      render json: @version.errors, status: :unprocessable_entity
    end
  end

  # DELETE /versions/1
  def destroy
    @version.destroy
  end

  private

  def set_version
    @version = Version.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def version_params
    params.fetch(:version, {})
  end
end
