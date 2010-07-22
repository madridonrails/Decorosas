class ShopsController < ApplicationController

  before_filter :find_shop, :except => [:new, :create, :index]

  def index
    @shops = Shop.paginate(
      :page => params[:page],
      :per_page => PAGINATION_PER_PAGE
    )

    if @shops.empty?
      flash[:notice] = t'shop.no_shop'
    end

  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(params[:shop])
    if (@shop.save)
      redirect_to shops_url
    else
      render :action => :new
    end
  end

  def edit

  end

  def update
    @shop.update_attributes(params[:shop])

    if @shop.save
      redirect_to shops_url
    else
      render :action => :edit
    end
  end

  def destroy
    if @shop.destroy
      redirect_to shops_url
    else
      # de momento va a la lista, que es donde se borran
      if (!@shop.errors.blank?)
        flash[:notice] = @shop.errors.full_messages.to_s
      else
        flash[:notice] = 'shop could not be deleted!'
      end
      redirect_to shops_url
    end

  end

  def show

  end

private

  def authorized?
    logged_in? && is_admin?
  end

  def access_denied
    if logged_in?
      flash[:notice] = t'general.you_must_be_admin'
      redirect_to root_path
    else
      flash[:notice] = t'general.you_must_be_logged_in'
      redirect_to new_session_path
    end
  end

  def find_shop
    @shop = Shop.find(params[:id])
  end

end
