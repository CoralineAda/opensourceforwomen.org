class Dashboard

  attr_reader :user

  def initialize(args={})
    @user = args[:user]
  end

  def pair_partners
    self.user.pair_partners
  end

  def unread_messages
    self.user.unread_messages
  end

  def projects
    @projects ||= self.user.projects.order(:name)
  end

end