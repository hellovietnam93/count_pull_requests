class CountPullRequests::QueryConditionsController < ApplicationController
  before_action :load_query, only: :update

  def update
    service = CountPullRequests.new user: current_user, query: @query,
      repository: @query.repository
    service.call
    redirect_to @query
  end

  private

  def load_query
    @query = QueryCondition.find_by id: params[:id]

    unless @query
      flash[:error] = t ".not_found"
      redirect_to root_path
    end
  end
end
