class Dashboard

  attr_reader :user

  def initialize(args={})
    @user = args[:user]
  end

  def pair_partners
    self.user.pair_partners
  end

  def projects
    @projects ||= self.user.projects.order_by(&:name)
  end

end