class Sign

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
 
  has_and_belongs_to_many :projects

  validates_presence_of :name
  validates_uniqueness_of :name

end
