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

end