class Owner < ActiveRecord::Base

  has_secure_password

  has_many :bikes
  has_many :brands, through: :bikes

end
