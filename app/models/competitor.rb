class Competitor < ActiveRecord::Base
  belongs_to :competition

  validates :name, presence: true
  validates :number_races, presence: true
end
