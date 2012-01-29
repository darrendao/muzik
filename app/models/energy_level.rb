class EnergyLevel < ActiveRecord::Base
  has_many :energy_level_intervals, :dependent => :destroy
  def self.non_holiday
    EnergyLevel.order('name').select{|e| e.name !~ /^H\d/}
  end
end
