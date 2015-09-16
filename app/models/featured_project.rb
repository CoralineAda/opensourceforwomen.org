class FeaturedProject < ActiveRecord::Base

  validates_presence_of :url, :name, :description
  validates_uniqueness_of :url, :name
  validates_format_of :url, :with => URI::regexp(%w(http https))

  belongs_to :user

  scope :active, ->{ where(is_active: true) }

end
