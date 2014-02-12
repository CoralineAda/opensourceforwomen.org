class Owner

  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :projects

  field :login
  field :remote_id
  field :type
  field :gravatar_id
  field :site_admin

  def self.find_or_create_by(params={})
    where(remote_id: params[:id]).first || create!(params)
  end

  def id=(value)
    self.remote_id = value
  end

end