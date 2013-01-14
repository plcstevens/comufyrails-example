class User < ActiveRecord::Base
  attr_accessible :dob, :facebook_id, :fact

  validates :facebook_id, :presence => true, :uniqueness => true
  validates :fact,        :presence => true
  validates :dob,         :timeliness => { :on_or_before => :today, :type => :date }

  # Goes through all users, checking their data and updating it.
  def self.update_with_comufy
    Comufyrails::Connection.users do |users, total, to, from|
      users.each do |user|
        # each user is a hash containing two keys; account and tagValues.
        # account contains two keys "name" and "fbId".
        account = user.delete("account")
        name    = account.delete("name")
        fbid    = account.delete("fbId")

        # tagValues contains every tag for this user, including any custom ones you have set.
        tags = user.delete("tagValues")
        dob  = tags.delete("dob")
        fact = tags.delete("fact")

        user = User.where("facebook_id = ?", fbid).first
        if user
          user.dob  = dob   if dob
          user.fact = fact  if fact
          user.save
        end
      end
    end
  end

  # Queries this user against Comufy, and updates the database accordingly.
  def update_with_comufy
    Comufyrails::Connection.user(self.facebook_id) do |account, tags, other|

      # just to confirm we have the right account check these values before saving
      name = account.delete("name")
      fbid = account.delete("fbId")

      # get our unique data tags
      tag_dob  = tags.delete("dob")
      tag_fact = tags.delete("fact")

      if fbid == self.facebook_id
        self.dob  = tag_dob  if tag_dob
        self.fact = tag_fact if tag_fact
        self.save
      end
    end
  end

end
