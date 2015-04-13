class Player < ActiveRecord::Base
  has_many :cards, dependent: :destroy
end
