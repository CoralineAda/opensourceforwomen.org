class PairPartnership

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :originator, class_name: "User"
  belongs_to :partner, class_name: "User"

end