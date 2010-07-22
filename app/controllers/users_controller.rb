class UsersController < ApplicationController

  before_filter :login_required
  before_filter :find_user, :except => [:index, :new, :create]
  
  def index
    @users = User.paginate(
      :page => params[:page],
      :per_page => PAGINATION_PER_PAGE
    )
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.shop_id = params[:user][:shop_id]
    if @user.save(true)
      redirect_to users_url
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    @user.update_attributes(params[:user])
    @user.admin = params[:user][:admin]
    @user.shop_id = params[:user][:shop_id]
    if @user.save
      redirect_to users_url
    else
      render :action => :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_url
    else
      if (!@user.errors.blank?)
        flash[:notice] = @user.errors.full_messages.to_s
      else
        flash[:notice] = 'User could not be deleted!'
      end
      redirect_to users_url
    end

  end

  def show

  end
  
  private
  def authorized?
    is_admin? || (logged_in? && params[:id].to_i == current_user.id && ['edit', 'update'].index(params[:action]))
  end
  
  def access_denied
    if logged_in?
      redirect_to edit_user_url(current_user)
    else
      flash[:notice] = t'general.you_must_be_logged_in'
      redirect_to new_session_url
    end
  end

  def find_user
    @user = User.find(params[:id])
  end
end
