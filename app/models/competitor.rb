class Competitor < ActiveRecord::Base
  belongs_to :competition

  validates :name, :price, :number_races, :paid, presence: true
end
