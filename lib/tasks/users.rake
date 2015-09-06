namespace :users do

  desc "Create admin user"
  task :load => :environment do
    user = User.new
    user.username = "admin"
    user.email = "admin@os4w.org"
    user.password = "foo12345"
    user.password_confirmation = "foo12345"
    user.is_frozen = false
    user.is_admin = true
    user.save
    user.activate!
  end
end
