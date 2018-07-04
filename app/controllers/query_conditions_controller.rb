class QueryConditionsController < ApplicationController
  before_action :load_repository, only: %i(new create)
  before_action :load_query_condition, only: %i(show edit update destroy export)

  def new
    @query_condition = @repository.query_conditions.new
  end

  def create
    @query_condition =
      @repository.query_conditions.new query_condition_params.merge(user_id: current_user.id)

    if @query_condition.save
      flash[:success] = t ".created"
      redirect_to @query_condition
    else
      flash[:error] = t ".not_created"
      render :new
    end
  end

  def show
    @repository = @query_condition.repository
  end

  def edit; end

  def update
    if @query_condition.update_attributes query_condition_params
      flash[:success] = t ".updated"
      redirect_to @query_condition
    else
      flash[:error] = t ".not_updated"
      render :edit
    end
  end

  def destroy
    if @query_condition.destroy
      flash[:success] = t ".deleted"
    else
      flash[:error] = t ".not_deleted"
    end
    redirect_to @repository
  end

  def export
    @pull_requests = @query_condition.pull_requests
    @headers = ["#", "Author", "PR ID", "Pull Request", "Line of code +", "Line of code -"]
    filename = "pull_requests.xlsx"
    respond_to do |format|
      format.xlsx{response.headers['Content-Disposition'] = "attachment; filename=#{filename}"}
    end
  end

  private

  def query_condition_params
    params.require(:query_condition).permit QueryCondition::ATTRIBUTE_PARAMS
  end

  def load_query_condition
    @query_condition = QueryCondition.find_by id: params[:id]

    unless @query_condition
      flash[:error] = t ".not_found"
      redirect_to @query_condition.repository
    end
  end

  def load_repository
    @repository = Repository.find_by id: params[:repository_id]

    unless @repository
      flash[:error] = t ".not_found"
      redirect_to root_path
    end
  end
end
