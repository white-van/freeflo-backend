class PullRequestsController < ApplicationController
  before_action :authenticate_and_set_user, except: [:show, :index]
  before_action :set_pull_request, only: [:show, :update, :destroy]
  before_action :set_project, only: [:index, :create]

  # GET /projects/1/pull_requests
  def index
    @pull_requests = PullRequest.page(@page).per(@per)
    render 'pull_requests/show', status: :created
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

  # POST /pull_requests/1/merge
  def merge
    pr_branch = @pull_request.branch
    latest_version_in_pr = @pull_request.latest_version
    merge_commit_opts = {
      title: "Merge pull request ##{@pull_request.id} from branch #{pr_branch.name}",
      branch_id: @project.branch_or_main.id,
      content: latest_version_in_pr.content,
      user_id: latest_version_in_pr.user_id
    }
    @merge_commit = Version.new(merge_commit_opts)

    ActiveRecord::Base.transaction do
      @merge_commit.save!
      @pull_request.update!(status: 'merged')
    end

    head :created
  rescue ActiveRecord::Rollback
    render json: @merge_commit.errors, status: :unprocessable_entity
  end

  # POST /pull_requests/1/status
  def status
    return render json: { error: 'Need a status!' }, status: :bad_request unless params[:status].present?

    # Backwards comp. Accepted will be removed in favor of status
    accepted = params[:status] == 'accepted'

    if @pull_request.update(status: params[:status], accepted: accepted)
      render 'pull_requests/show', status: :created
    else
      render json: @pull_request.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pull_requests/1
  def update
    if @pull_request.update(pull_request_params)
      rrender 'pull_requests/show', status: :created
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
