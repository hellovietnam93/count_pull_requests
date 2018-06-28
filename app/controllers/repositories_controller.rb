class RepositoriesController < ApplicationController
  before_action :load_reposiroty, only: %i(show edit update destroy)

  def index
    @repositories = current_user.repositories
  end

  def new
    @repository = current_user.repositories.new
  end

  def create
    @repository = current_user.repositories.new respository_params
    if @repository.save
      flash[:success] = t ".created"
      redirect_to @repository
    else
      flash[:error] = t ".not_created"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @repository.update_attributes respository_params
      flash[:success] = t ".updated"
      redirect_to @repository
    else
      flash[:error] = t ".not_updated"
      render :edit
    end
  end

  def destroy
    if @repository.destroy
      flash[:success] = t ".deleted"
    else
      flash[:error] = t ".not_deleted"
    end
    redirect_to @repository
  end

  private

  def respository_params
    params.require(:repository).permit :name
  end

  def load_reposiroty
    @repository = Repository.find_by id: params[:id]

    unless @repository
      flash[:error] = t ".not_found"
      redirect_to root_path
    end
  end
end
