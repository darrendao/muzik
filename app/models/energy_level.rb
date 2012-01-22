class EnergyLevel < ActiveRecord::Base
  has_many :energy_level_intervals, :dependent => :destroy
end
