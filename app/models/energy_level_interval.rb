class EnergyLevelInterval < ActiveRecord::Base
  belongs_to :energy_level
  belongs_to :group
end
