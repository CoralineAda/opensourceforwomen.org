module Project::Github

  def update
    begin
      latest = Octokit.repo repo_path
      update_attributes(
        name:         latest.name,
        full_name:    latest.full_name,
        description:  latest.description,
        homepage:     latest.homepage,
        language:     latest.language,
        remote_id:    latest.id
      )
    rescue Exception => e
      errors.add(:update, "failed from #{repo_path} with message #{e}")
    ensure
      return self
    end
  end

  def repo_path
    self.repo_url.split("/")[-2..-1].join("/")
  end

end
