class UserObserver < ActiveRecord::Observer

  def after_save(user)
    dob = (user.dob.to_f * 1000.0).to_i
    COMUFY.store_user(APPNAME, user.facebook_id.to_s, { dob: dob, fact: user.fact  })
  end

  def after_update(user)
    dob = (user.dob.to_f * 1000.0).to_i
    COMUFY.store_user(APPNAME, user.facebook_id.to_s, { dob: dob, fact: user.fact  })
  end
end
