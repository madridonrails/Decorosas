class ClientsController < ApplicationController

  before_filter :login_required
  def index
    @clients = Client.paginate(
      :page => params[:page],
      :per_page => PAGINATION_PER_PAGE
    )

    if @clients.empty?
      flash[:notice] = t'client.no_client'
    end

  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
    if (@client.save)
      redirect_to :controller => :projects, :action => :new, :client_id => @client.id
    else
      render :action => :new
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update

    @client = Client.find(params[:id])
    @client.update_attributes(params[:client])

    if @client.save
      redirect_to clients_url
    else
      render :action => :edit
    end
  end

  def destroy
    @client = Client.find(params[:id])
    if @client.destroy
      redirect_to clients_url
    else
      if (!@client.errors.blank?)
        flash[:notice] = @client.errors.full_messages.to_s
      else
        flash[:notice] = 'Client could not be deleted!'
      end
      redirect_to clients_url
    end

  end

  def show
    @client = Client.find(params[:id])
  end

private

  def authorized?
    logged_in?
  end

  def access_denied
    flash[:notice] = t'general.you_must_be_logged_in'
    redirect_to new_session_url
  end
end
