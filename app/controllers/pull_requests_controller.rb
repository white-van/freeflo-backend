class PullRequestsController < ApplicationController
  before_action :set_pull_request, only: [:show, :update, :destroy]
  before_action :set_project, only: [:index, :create]
  before_action :authenticate_and_set_user, except: [:show, :index]

  # GET /projects/1/pull_requests
  def index
    @pull_requests = PullRequest.page(@page).per(@per)

    render json: @pull_requests
  end

  # GET /me/pull_requests/owned
  def owned
    @pull_requests = PullRequest.where(user_id: current_user.id).page(@page).per(@per)
  end

  # TODO
  # GET /me/pull_requests/to_review
  def to_review; end

  # GET /pull_requests/1
  def show
    render json: @pull_request
  end

  # POST /projects/1/pull_requests
  def create
    creation_params = pull_request_params.merge({
                                                  project_id: params[:id],
                                                  user_id: current_user.id
                                                })
    @pull_request = PullRequest.new(creation_params)

    if @pull_request.save
      render json: @pull_request, status: :created, location: @pull_request
    else
      render json: @pull_request.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pull_requests/1
  def update
    if @pull_request.update(pull_request_params)
      render json: @pull_request
    else
      render json: @pull_request.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pull_requests/1
  def destroy
    @pull_request.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pull_request
    @pull_request = PullRequest.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def pull_request_params
    params.require(:pull_request).permit(
      :title,
      :reviewers
    )
  end
end
