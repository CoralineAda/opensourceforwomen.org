class User

  include Mongoid::Document
  include Sorcery::Model

  authenticates_with_sorcery!

  index({ activation_token: 1 }, { unique: true, background: true })

  validates :password, length: { minimum: 8 }
  validates :password, confirmation: true
  validates :email, uniqueness: true, email_format: { message: 'has invalid format' }

end
