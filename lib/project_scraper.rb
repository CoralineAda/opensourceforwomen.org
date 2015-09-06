class ProjectScraper

  require 'open-uri'
  require 'nokogiri'

  attr_accessor :current_page_html

  IGNORE_LIST = ["CSS", "HTML", "Makefile", "Shell", "Smarty", "TeX", "XSLT", "PLSQL", "PLpgSQL", "Protocol Buffer", "Mercury", "Groff"]
  MANUAL_LIST = [
    "24pullrequests/24pullrequests",
    "aasm/aasm",
    "algorrent/algorrent",
    "angular/code-of-conduct",
    "formly-js/angular-formly",
    "atom/atom",
    "babel/babel",
    "bundler/bundler",
    "fnichol/chef-rvm",
    "cocoapods/cocoapods",
    "composer/composer",
    "jordanekay/Crackle",
    "eldest-daughter/ed-questionnaire",
    "atom/electron",
    "exercism/exercism.io",
    "coraline/fukuzatsu",
    "gitlabhq/gitlabhq",
    "growingdevs/growingdevs.github.io",
    "hacken-in/website",
    "adireddy/haxe-pixi",
    "caskroom/homebrew-cask",
    "myfreeweb/httpotion",
    "julianguyen/ifme",
    "terrytangyuan/lfda",
    "jekyll/jekyll",
    "jruby-gradle/jruby-gradle-plugin",
    "lotus/lotus",
    "jordanekay/Mensa",
    "syegulalp/MeTal",
    "Moya/Moya",
    "moshez/ncolony",
    "oapi/shieldsup",
    "OpenDroneMap/OpenDroneMap",
    "jordanekay/Ornament",
    "CenturyLinkLabs/panamax-ui",
    "iancooper/Paramore",
    "bruceadams/pmap",
    "puppet-community",
    "praw-dev/praw",
    "graycatlabs/PyBBIO",
    "kickstarter/rack-attack",
    "rails/rails",
    "rom-rb/rom",
    "rspec/rspec",
    "apeiros/ruby-community",
    "rubygems/rubygems.org",
    "rvm/rvm",
    "ReactiveX/RxJS",
    "qa-tools/qa-tools",
    "jonathanKingston/secure.fail",
    "shoes/shoes4",
    "snipe/snipe-it",
    "spree/spree",
    "rtorr/vim-cheat-sheet",
    "voltrb/volt",
    "krisleech/wisper",
    "xoreos/xoreos"
  ]

  def parse_manual
    create_projects(MANUAL_LIST)
  end

  def parse
    (1..500).each do |i|
      puts "======================="
      puts "Scraping page #{i}"
      puts "======================="
      self.current_page_html = Nokogiri::HTML(open("#{starting_url}&p=#{i}"))
      break unless create_projects(project_titles)
      sleep 5
    end
  end

  def create_projects(names)
    return false unless names.any?
    names.each do |title|
      if Project.find_by(full_name: title)
        puts "Skipping #{title}..."
        next
      end
      if project = project_detail(title)
        next unless language_name = project_language(project)
        language = Language.find_or_create_by(name: language_name).name
        next if ['HTML', 'CSS'].include? language
        Project.create(
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
    IGNORE_LIST.each do |language|
      languages.delete(language)
    end
    languages.any? && languages.sort.last[0].to_s
  end

end