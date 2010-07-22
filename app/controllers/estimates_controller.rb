class EstimatesController < ApplicationController

  before_filter :find_estimate, :except => [:new, :create]
  before_filter :check_nested_ids
  before_filter :login_required

  def new
    @estimate = Estimate.new
    @estimate.project_id = params[:project_id]
  end

  def create
    @estimate = Estimate.new(params[:estimate])
    @estimate.project_id = params[:project_id]
    if @estimate.save
      flash[:success] = t('estimate.create.success')
      redirect_to edit_project_path(params[:project_id])
    else
      render :action => :new
    end
  end

  def edit

  end

  def update
    params[:estimate][:measurement_ids] ||= []
    if @estimate.update_attributes(params[:estimate])
      flash[:success] = t('estimate.update.success')
      redirect_to edit_project_path(params[:project_id])
    else
      render :action => :edit
    end
  end

  def destroy
    @estimate.destroy
    redirect_to projects_path
  end

  def show

  end

  def authorized?
    logged_in? and (is_admin? || is_current_shop?(Project.find(params[:project_id]).shop))
  end

  def access_denied
    if logged_in?
      flash[:notice] = t'general.not_enough_permissions'
      redirect_back_or_default(edit_project_path(params[:project_id]))
    else
      flash[:notice] = t'general.you_must_be_logged_in'
      redirect_to new_session_path
    end
  end

private

  def find_estimate
    @estimate = Estimate.find(params[:id])
  end

  def check_nested_ids
    unless params[:id].blank? || Estimate.find(params[:id]).project_id == params[:project_id].to_i
      flash[:error] = t'general.url_params_error'
      redirect_back_or_default('/')
    end
  end

end
