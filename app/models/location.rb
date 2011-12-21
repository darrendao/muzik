class Location < ActiveRecord::Base
  has_many :business_hours, :as => :schedulable
  accepts_nested_attributes_for :business_hours, :allow_destroy => true,
                                :reject_if => proc {|attrs|
                                  attrs.any? {|k,v| v.blank?}
                                }

  belongs_to :group
  has_many :black_lists
end
