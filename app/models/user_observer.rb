class UserObserver < ActiveRecord::Observer

  # This can be used when you want to update data in all cases. However, it can become a problem
  # when updating from the Comufy servers, as it will run after your action. Instead, it is better
  # to repeat the behaviour for the create/update as these won't get called.
  #def after_save(user)
  #  data = { dob: user.dob.to_comufy_time, fact: user.fact }
  #  Comufyrails::Connection.store_user(user.facebook_id, data)
  #end

  def after_create(user)
    store(user)
  end

  def after_update(user)
    store(user)
  end

  private

  def store(user)
    data = { dob: user.dob.to_comufy_time, fact: user.fact }
    Comufyrails::Connection.store_user(user.facebook_id, data)
  end
end
