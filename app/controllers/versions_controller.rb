class VersionsController < ApplicationController
  before_action :set_version, only: [:show, :update, :destroy]
  before_action :set_project, only: [:index, :create]
  before_action :set_branch, only: [:index, :create]
  before_action :authenticate_and_set_user, except: [:show, :index]

  # GET /projects/1/commits
  def index
    @versions = @branch.versions.page(@page).per(@per)
    render 'versions/index', status: :created
  end

  # GET /versions/1
  def show
    render 'versions/show', status: :created
  end

  # POST /projects/1/commits
  # Must pass commit: {branch_name: ...} in the body of the request. Default is 'main'
  def create
    creation_params = version_params
    @version = Version.new(creation_params)
    @version.branch_id = @branch.id
    ActiveRecord::Base.transaction do
      @version.save!
      current_user.add_contribution(@project.id)
    end
    render json: @version, status: :created, location: @version
  rescue ActiveRecord::Rollback
    render json: @version.errors, status: :unprocessable_entity
  end

  # PATCH/PUT /versions/1
  def update
    if @version.update(version_params)
      render 'versions/show', status: :created
    else
      render json: @version.errors, status: :unprocessable_entity
    end
  end

  # DELETE /versions/1
  def destroy
    @version.destroy
    head :ok
  end

  private

  def set_version
    @version = Version.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def set_branch
    @branch = @project.branch_or_main(params.dig(:commit, :branch_name))
  end

  # Only allow a trusted parameter "white list" through.
  def version_params
    params.require(:commit).permit(
      :content,
      :branch_name
    )
  end
end
