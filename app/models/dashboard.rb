class Dashboard

  attr_reader :user

  def initialize(args={})
    @user = args[:user]
  end

  def pair_partner_count
    @projects && @projects.count || 0
  end

  def pair_partners
    self.user.pair_partners
  end

  def project_count
    @projects && @projects.count || 0
  end

  def projects
    @projects ||= self.user.projects
  end

end