class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def get_user_info_by_number (number)
  	encrypted_number = Digest::SHA1.hexdigest("#{@number}sm1thsbeach_21_wls")
  	@user = User.find_by_number(encrypted_number)
  	return @user
  end

end
