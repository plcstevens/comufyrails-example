class UserObserver < ActiveRecord::Observer

  def after_save(user)
    data = { dob: user.dob.to_comufy_time, fact: user.fact }
    Comufyrails::Connection.store_user(user.facebook_id, data)
  end
end
