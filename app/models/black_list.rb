class BlackList < ActiveRecord::Base
  belongs_to :location
  belongs_to :song
end
