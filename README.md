os4w.org
======================

A resource for connecting women in technology with friendly and welcoming open
source projects.

## To install and run the application locally

### Pre-requisites

- Postgres (OSX users can run `brew install postgresql`)
- bundler (`gem install bundler`)
- Ruby 2.2.1

### Environment variables

Create a .env file in the root folder, and add the following keys. For development purposes,
the values don't really matter.

    ADMIN_EMAIL=foo
    MAILCHIMP_LIST_ID=foo
    MAILCHIMP_API_KEY=foo
    SENDGRID_USERNAME=foo
    SENDGRID_PASSWORD=foo
    GITHUB_USER=foo
    GITHUB_TOKEN=foo

### Installation

- `bundle install`
- (start your Postgres db)
- `rake db:create` (TODO: create seed data)
- (remember to migrate which in a Rails 4 app is `rake db:migrate`)

To create an initial admin user, fire up `rails c` and do the following:

    u = User.create(username: "Whatever", password: "foo123456", email: "me@domain.org", password_confirmation: "foo123456")
    u.activate!
    u.is_admin = true
    u.save

### Running the server

- `rails s`

## Code of Conduct
This project is governed by the Contributor Covenant. All participants agree to
abide by its rules. For more information, see CODE_OF_CONDUCT.md

## Contributing
Everyone is welcome to contribute to the project by creating issues or sending pull requests.
If you plan on sending a pull request, take a look at the following github articles:

- [Working with forks](https://help.github.com/articles/working-with-forks/)
- [Using pull requests](https://help.github.com/articles/using-pull-requests)
- [Managing Remotes](https://help.github.com/articles/which-remote-url-should-i-use/)
