module UserHelper
  def activate_user user
    user.activated? ? "Activated" : "Not Activated"
  end
end
