class ProjectScraper

  require 'open-uri'
  require 'nokogiri'

  attr_accessor :current_page_html

  def parse
    (1..500).each do |i|
      self.current_page_html = Nokogiri::HTML(open("#{starting_url}&p=#{i}"))
      break unless create_projects
      sleep 5
    end
  end

  def create_projects
    return false unless project_titles.any?
    project_titles.each do |title|
      if Project.find_by(full_name: title)
        puts "Skipping #{title}..."
        next
      end
      if project = project_detail(title)
        next unless language_name = project_language(project)
        language = Language.find_or_create_by(name: language_name).name
        next if ['HTML', 'CSS'].include? language
        Project.create!(
          name: project['name'],
          full_name: project['full_name'],
          repo_url: project['html_url'],
          description: project['description'],
          has_coc: true,
          language: language
        )
      end
      sleep 1
    end
  end

  def project_titles
    self.current_page_html.css('.title a:first').map(&:text)
  end

  def project_detail(repo)
    JSON.load(
      open(url_for(repo), http_basic_authentication: [ENV['GITHUB_USER'], ENV['GITHUB_TOKEN']])
    )['items'].first
  end

  def url_for(repo)
    user, project = repo.split('/')
    "https://api.github.com/search/repositories?q=#{project}+user:#{user}"
  end

  def starting_url
    "https://github.com/search?&q=%22contributor+covenant%22&type=Code&ref=searchresults"
  end

  def project_language(project)
    return unless project['languages_url']
    languages = JSON.load(open(
      project['languages_url'],
      http_basic_authentication: [ENV['GITHUB_USER'], ENV['GITHUB_TOKEN']]
    ))
    ["CSS", "HTML", "Makefile", "Shell", "TeX"].each do |language|
      languages.delete(language)
    end
    languages.any? && languages.sort.last[0].to_s
  end

end