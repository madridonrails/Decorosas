class MeasurementsController < ApplicationController

  before_filter :find_measurement, :except => [:new, :create]
  before_filter :check_nested_ids
  before_filter :login_required

  def new
    @measurement = Measurement.new
    @measurement.project_id = params[:project_id]
  end

  def create

    @measurement = Measurement.new(params[:measurement])
    @measurement.project_id = params[:project_id]

    if @measurement.save
      flash[:success] = t('measurement.create.success')
      redirect_to edit_project_path(params[:project_id])
    else
      render :action => :new
    end
  end

  def edit

  end

  def update
    params[:measurement][:estimate_ids] ||= []
    if @measurement.update_attributes(params[:measurement])
      flash[:success] = t('measurement.update.success')
      redirect_to edit_project_path(params[:project_id])
    else
      render :action => :edit
    end
  end

  def destroy
    @measurement.destroy
    redirect_to edit_project_path(params[:project_id])
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

  def find_measurement
    @measurement = Measurement.find(params[:id])
  end

  def check_nested_ids
    unless params[:id].blank? || Measurement.find(params[:id]).project_id == params[:project_id].to_i
      flash[:error] = t'general.url_params_error'
      redirect_back_or_default(edit_project_path(params[:project_id]))
    end
  end
end
