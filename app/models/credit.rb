class Credit < ActiveRecord::Base
  belongs_to :user

  # validates :value
end
