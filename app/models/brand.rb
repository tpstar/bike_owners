class Brand < ActiveRecord::Base

  has_many :bikes
  has_many :owners, through: :bikes

end
