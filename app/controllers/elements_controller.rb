class ElementsController < ApplicationController
  before_filter :login_required
  before_filter :find_element, :except => [:index, :new, :create]

  def index
    @elements = Element.paginate_by_project_id(
      params[:project_id],
      :per_page => PAGINATION_PER_PAGE,
      :page => params[:page]
    )
    if @elements.blank?
      flash[:notice] = t'element.no_elements'
    end

  end

  def new
    @element = Element.new
    @element.project_id = params[:project_id]
  end

  def create
    @element = Element.new(params[:element])
    @element.project_id = params[:project_id]

    if @element.save
      flash[:success] = t'element.create.success'
      redirect_to project_elements_path(params[:project_id])
    else
      render :action => :new
    end
  end

  def edit

  end

  def update
    if @element.update_attributes(params[:element])
      flash[:success] = t'element.update.success'
      redirect_to project_elements_path(params[:project_id])
    else
      render :action => :edit
    end
  end

  def show

  end

  def destroy
    if @element.destroy
      flash[:success] = t'element.destroy.success'
    else
      flash[:error] = t'element.destroy.error'
    end

    redirect_to project_elements_path(params[:project_id])
  end

  private

  def find_element
    @element = Element.find(params[:id])
  end

  def authorized?
    logged_in? and is_admin?
  end

  def access_denied
    if logged_in?
      flash[:notice] = t'general.not_enough_permissions'
      redirect_back_or_default(projects_path)
    else
      redirect_to new_session_path
    end
  end
end
