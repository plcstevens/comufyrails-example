class UserObserver < ActiveRecord::Observer

  # We need to convert the ISO time into unix time before we send it.
  # As we have named two tags called dob and fact, we just need to pass them in as the key.
  def after_save(user)
    dob = user.dob.to_time.to_i
    Comufyrails::Connection.store_user user.facebook_id, { dob: dob, fact: user.fact }
  end
end
