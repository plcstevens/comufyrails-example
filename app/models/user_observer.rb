class UserObserver < ActiveRecord::Observer

  def after_save(user)
    Comufyrails::Connection.store_user '284002537', { dob: 1355931600000, fact: "test" }
  end

  def after_update(user)
    Comufyrails::Connection.store_user '284002537', { dob: 1355931600000, fact: "test" }
  end
end
