module SessionsHelper
  def current_user
    unless cookies[:user_id].nil?
      User.find(cookies[:user_id])
    else
      return nil
    end
  end


  def sign_in(user)
    cookies.permanent[:user_id] = {
      :value => user._id,
      :httponly => true
    }
  end
end
