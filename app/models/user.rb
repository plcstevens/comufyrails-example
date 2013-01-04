class User < ActiveRecord::Base
  attr_accessible :dob, :facebook_id, :fact

  validates :facebook_id, :presence => true, :uniqueness => true
  validates :fact,        :presence => true
  validates :dob,         :timeliness => { :on_or_before => :today, :type => :date }

end
