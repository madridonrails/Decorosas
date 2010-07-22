class ProjectsController < ApplicationController

  before_filter :find_project, :except => [:index, :new, :create]
  before_filter :login_required

  def index
    @query_order = (params[:order].blank? ? 'code': params[:order])
    @direction = (params[:direction].blank? ? 'asc' : params[:direction])
    @filter = params[:filter]
    conditions = [' 1 = 1 ']
    unless @filter.blank?
      unless @filter[:code].blank?
        conditions[0] << ' AND projects.code LIKE ?'
        conditions << "%#{@filter[:code]}%"
      end
      unless @filter[:state].blank?
        conditions[0] << ' AND projects.state LIKE ?'
        conditions << "#{@filter[:state]}"
      end
      unless @filter[:address].blank?
        conditions[0] << ' AND projects.address LIKE ?'
        conditions << "%#{@filter[:address]}%"
      end

    end

    if is_central? or is_admin?
      @projects = Project.paginate(
        :conditions => conditions,
        :order => "#{@query_order} #{@direction}",
        :per_page => PAGINATION_PER_PAGE,
        :page => params[:page])
    else
      @projects = Project.paginate_by_shop_id(
        current_user.shop.id,
        :conditions => conditions,
        :order => "#{@query_order} #{@direction}",
        :per_page => PAGINATION_PER_PAGE,
        :page => params[:page]
      )
    end

    if @projects.empty?
      flash[:notice] = t('project.no_projects')
    end
  end

  def new
    @project = Project.new
    @project.client_id = params[:client_id] unless params[:client_id].blank?
  end

  def create
    @project = Project.new(params[:project])
    @project.address = @project.client.address rescue '' if @project.address.blank?
    @project.code = @project.shop.name + '/' + @project.client.address rescue '' if @project.code.blank?
      if @project.save
        flash[:success] = t('project.create.success')
        redirect_to edit_project_path(@project)
      else
        render :action => :new
      end
  end

  def edit

  end

  def update
    params[:project][:address] = @project.client.address if params[:project][:address].blank?
    params[:project][:code] = @project.shop.name + '/' + @project.client.address if params[:project][:code].blank?
    if @project.update_attributes(params[:project])
      flash[:success] = t('project.update.success')
      redirect_to projects_path
    else
      render :action => :edit
    end
  end

  def show

  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def accept
    if @project.accept!
      flash[:success] = t'project.events.accept.success'
    else
      flash[:error] = t'project.events.accept.error'
    end
    redirect_to :action => index, :page => params[:page]
  end

  def wait
    if @project.wait!
      flash[:success] = t'project.events.wait.success'
    else
      flash[:error] = t'project.events.wait.error'
    end
    redirect_to :action => index, :page => params[:page]
  end

  def measure
    if @project.measure!
      flash[:success] = t'project.events.measure.success'
    else
      flash[:error] = t'project.events.measure.error'
    end
    redirect_to :action => index, :page => params[:page]
  end

  def order
    if @project.order!
      flash[:success] = t'project.events.order.success'
    else
      flash[:error] = t'project.events.order.error'
    end
    redirect_to :action => index, :page => params[:page]
  end

  def receive
    if @project.receive!
      flash[:success] = t'project.events.receive.success'
    else
      flash[:success] = t'project.events.receive.error'
    end
    redirect_to :action => index, :page => params[:page]
  end

  def install
    if @project.install!
      flash[:success] = t'project.events.install.success'
    else
      flash[:error] = t'project.events.install.error'
    end
    redirect_to :action => index, :page => params[:page]
  end

  def complete
    if @project.complete!
      flash[:success] = t'project.events.complete.success'
    else
      flash[:error] = t'project.events.complete.error'
    end
    redirect_to :action => index, :page => params[:page]
  end

private

  def authorized?
    logged_in? and check_permissions
  end

  def access_denied
    if logged_in?
      flash[:notice] = t'general.not_enough_permissions'
      redirect_back_or_default(projects_path)
    else
      flash[:notice] = t'general.you_must_be_logged_in'
      redirect_to new_session_path
    end
  end

  def find_project
    @project = Project.find(params[:id])
  end

private

  def check_permissions
    @project ||= Project.find(params[:id]) rescue nil
    if is_admin? 
      return true
    end
    
    unless (is_admin?)
      has_permissions = case params[:action]
        when 'create' then (params[:project][:shop_id].to_i == current_user.shop_id)
        when 'edit' || 'show' then (is_current_shop?(@project.shop) || is_central?)
        when 'update' then is_current_shop?(@project.shop)
        when 'destroy' then is_current_shop?(@project.shop)
        when 'index' then true
        when 'new' then true
        when 'order' then is_current_shop?(@project.shop)
        when 'receive' then is_current_shop?(@project.shop) || is_central?
        when 'install' then is_current_shop?(@project.shop)
        when 'complete' then false
      end
    end
    has_permissions || is_admin?
  end
end
