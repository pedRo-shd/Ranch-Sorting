class Competition < ActiveRecord::Base

  has_many :competitors

  validates :title, presence: true
  validates :price, presence: true
end
