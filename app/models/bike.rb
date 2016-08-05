class Bike < ActiveRecord::Base

  belongs_to :owner
  belongs_to :brand

end
