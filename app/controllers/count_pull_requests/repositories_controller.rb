class CountPullRequests::RepositoriesController < ApplicationController
  before_action :load_reposiroty, only: :update

  def update
    service = CountPullRequests.new user: current_user, repository: @repository
    service.call
    redirect_to @repository
  end

  private

  def load_reposiroty
    @repository = Repository.find_by id: params[:id]

    unless @repository
      flash[:error] = t ".not_found"
      redirect_to root_path
    end
  end
end
