class User < ActiveRecord::Base
  attr_accessible :dob, :facebook_id, :fact

  validates :facebook_id, :presence => true, :uniqueness => true
  validates :fact,        :presence => true
  validates :dob,         :timeliness => { :on_or_before => :today, :type => :date }

  # Queries this user against Comufy, and updates the database accordingly.
  def update_with_comufy
    Comufyrails::Connection.user(facebook_id) do |account, tags, other|
      facebook_id = account["fbId"]
      dob         = tags["dob"]
      fact        = tags["Fact"]

      user = User.where("facebook_id = ?", facebook_id).first
      if user
        user.dob  = dob
        user.fact = fact
        user.save!
      end
    end
  end

  # Goes through all users, checking their data and updating it.
  def self.update_users_with_comufy
    Comufyrails::Connection.users do |users, total, to, from|
      users.each do |user|
        account = user.delete("account")
        tags    = user.delete("tagValues")

        facebook_id = account["fbId"]
        dob         = tags["dob"]
        fact        = tags["Fact"]

        our_user = User.where("facebook_id = ?", facebook_id).first
        if our_user
          p "Found our user, let us update its entries!"
          our_user.dob  = dob
          our_user.fact = fact
          our_user.save!
        end
      end
    end
  end

end
