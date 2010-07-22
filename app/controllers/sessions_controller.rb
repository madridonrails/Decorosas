class SessionsController < ApplicationController
  include AuthenticatedSystem

  skip_before_filter :login_required
  def new

  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == '1'
        current_user.remmbember_me unless current_user.remember_token?
        cookies[:auth_token] = {:value => self.current_user.remember_token, :expires => self.current_user.remember_token_expires_at}
      end
      redirect_to projects_path and return
    else
      flash[:error] = t'session.login.failure'
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    redirect_back_or_default(new_session_url)
  end
end
