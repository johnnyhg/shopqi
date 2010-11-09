# encoding: utf-8
# 解决create方法中无法支持ajax提交的问题
# @see: http://stackoverflow.com/questions/3546289/override-devise-registrations-controller
class Members::RegistrationsController < Devise::RegistrationsController

  # 此方法重载至lib/devise/controllers/helpers.rb
  # @see: http://github.com/plataformatec/devise/blob/master/lib/devise/controllers/helpers.rb#L194
  #
  # Sign in an user and tries to redirect first to the stored location and
  # then to the url specified by after_sign_in_path_for.
  #
  # If just a symbol is given, consider that the user was already signed in
  # through other means and just perform the redirection.
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope      = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    @path = stored_location_for(scope) || after_sign_in_path_for(resource)
  end

end
