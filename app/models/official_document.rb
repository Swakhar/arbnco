class OfficialDocument < ActiveRecord::Base
  validates :metadata, presence: true
end
