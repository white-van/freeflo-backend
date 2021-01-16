class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy, :heart, :unheart, recommended]
  before_action :authenticate_and_set_user, except: [:show, :index]

  # GET /projects
  def index
    @projects = Project.page(@page).per(@per)

    render json: @projects
  end

  # GET /me/projects/recommended
  def recommended
    @projects = current_user.recommended_projects.page(@page).per(@per)
  end

  # GET /me/projects/owned
  def owned
    @projects = current_user.projects.page(@page).per(@per)
  end

  # GET /me/projects/unowned_contrib
  def unowned_contrib
    @projects = Project.joins(:contributions)
                       .where('contributions.user_id = ?', current_user.id)
                       .where.not('projects.user_id = ?', current_user.id)
                       .include(:user)
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    ActiveRecord::Base.transaction do
      @project = Project.create!(project_params)
      @main_branch = Branch.create!({ name: 'main', project_id: @project.id })
    end

    render json: @project, status: :created, location: @project
  rescue ActiveRecord::Rollback
    render(json: {
             project: @project.errors,
             branch: @branch.errors
           },
           status: :unprocessable_entity)
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # POST /projects/1/heart
  def heart
    current_user.like(@project)
  end

  # DELETE /projects/1/heart
  def unheart
    current_user.unlike(@project)
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def project_params
    params.require(:project).permit(
      :name,
      :description,
      :organization_id
    )
  end
end
