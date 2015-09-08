namespace :languages do

  desc "Set up default languages"
  task :initialize => :environment do
    [
      "Ruby",
      "Java",
      "Javascript",
      "Python",
      "Perl",
      "PHP",
      "C++",
      "Objective-C",
      "Visual Basic",
      "Swift",
      "F#"
    ].each do |language|
      Language.create(name: language)
    end
  end

  desc "migrate languages to text field"
  task :languages_fix => :environment do
    ExtendedProfile.all.each do |profile|
      profile.language_list = profile.languages.map(&:name).uniq.join(', ')
      profile.save
    end
  end

end