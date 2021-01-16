class ApplicationController < ActionController::API
  before_action :set_pagination

  def set_pagination
    @page = params[:page] || 1
    @per = params[:per] || 7
  end
end
