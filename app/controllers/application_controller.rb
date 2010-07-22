# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  before_filter :login_required
  before_filter :set_current_user

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '140adaee440e6b5c422067b3231ae59f'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password

  helper_method :is_admin?, :is_central?, :is_current_shop?
  def is_admin?
    logged_in? and current_user.admin?
  end

  def is_central?
    logged_in? and (current_user.shop.central? rescue false)
  end

  def is_current_shop?(shop)
    logged_in? and (current_user.shop == shop rescue false)
  end
  #before_filter :login_required

  I18n.locale = 'es-ES'
private

  def set_current_user
    User.current_user = current_user
  end
end