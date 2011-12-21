class EnergyLevel < ActiveRecord::Base
  validates_uniqueness_of :level, :scope => name
end
