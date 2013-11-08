# Start and Provision Virtual Machine

Download and install VirtualBox and Vagrant:

- [Download Virtualbox](https://www.virtualbox.org/wiki/Downloads)
- [Download Vagrant](http://downloads.vagrantup.com/)

```bash
vagrant up
```

The `provision.sh` is automatically executed and installs Ruby and the Postgres database.

# Create Rails Project

```bash
vagrant ssh

gem install bundler
gem install rails

cd /vagrant

rails new blog -d postgresql
cd blog

# change the username in config/database.yml to vagrant (has superuser privileges)

rake db:create
```

The `/vagrant` directory is a shared directory between your OS and the virtual machine.
You can use an editor like TextMate or Sublime Text to edit files from within your OS.

# Start Tmux

```bash
tmux
```

Press `Ctrl-B + "` to get a second shell for your convenience.
Switch between the shells by pressing Ctrl-B and the up/down arrow.
In the first shell i run the server and watch the log and in
the second shell i run rails and shell commands.

# Scaffold and Start Server

```bash
rails generate scaffold Post title:string text:text
rake db:migrate

rails server
```

Open a webbrowser and navigate to `http://localhost:3000/posts`.

# References

- [Rails API](http://api.rubyonrails.org/)
- [Postgres Docs](http://www.postgresql.org/docs/9.1/interactive/index.html)
- [Vagrant Docs](http://docs.vagrantup.com/v2/)

# Better Errors

[Better Errors](https://github.com/charliesome/better_errors) is a gem that provides a nicer stack trace and local variable assignments when something is wrong. Install in the `Gemfile`:

```ruby
group :development do
  gem "better_errors"
  gem "binding_of_caller"
end
```

Now run:

```bash
bundle
```

In the `config/environments/development.rb` add before the end:

```ruby
  BetterErrors::Middleware.allow_ip! ENV['TRUSTED_IP'] if ENV['TRUSTED_IP']
```

Now restart your server add allow your guest OS access:

```bash
TRUSTED_IP=10.0.2.2 rails server
```

# Slim Templates

[Slim Lang](Slim) is a lightweight templating language that can
replace erb templates. Install in the `Gemfile`:

```ruby
gem "slim"

group :development do
  gem "html2slim"
end
```

Restart the server to get the slim engine going. Convert an erb template
into a slim version using: `erb2slim example.html.erb example.html.slim`.
To convert all your erb templates into slim run in`irb`:

```ruby
Dir['**/*.erb'].each do |erb|
  slim = erb.gsub(/\.erb$/, '.slim')
  `erb2slim #{erb} #{slim}`
  `mv #{erb} #{erb}.bak`
end
```

Get Slim syntax highlighting working in Sublime Text by installing
[Package Control](https://sublime.wbond.net/installation). Restart
Sublime and use `Ctrl-Shift-P` followed by `Package Control: Install
Package` and select `Ruby Slim`.

[Haml](http://haml.info/) is another popular template language.

# Popular Gems

Many of these gems have excellent introductions at [Railscasts](http://railscasts.com/) by Ryan Bates.

- [Simple Form](https://github.com/plataformatec/simple_form) gives nice form helpers [Railscast #234](http://railscasts.com/episodes/234-simple-form).
- [Kaminari](https://github.com/amatsuda/kaminari) paginate through lists [Railscast #254](http://railscasts.com/episodes/254-pagination-with-kaminari). 
- [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) add image and file uploads [Railscast #253](http://railscasts.com/episodes/253-carrierwave-file-uploads).
- [Devise](https://github.com/plataformatec/devise) authenticates your users [Railscast #209](http://railscasts.com/episodes/209-introducing-devise).

# Backup Database

```bash
pg_dump blog_development >blog_backup.sql
```

# Access Gem Sources

Want to know what Rails is doing to make your app work?
Copy the gems into a location that is easy accessible.

```bash
cp -R ~/.gem /vagrant/gem_home
```

# Save Source in Github or Bitbucket

Use git on your local machine:

```
git config --global user.name "Your Name"
git config --global user.email "yourname@domain.com"

git init
git add -A
git commit -m 'initial commit'

git remote add origin git@github.com:yourname/yourrepo.git
git push -u origin master
```

# Cleanup the VM

```bash
vagrant destroy
```
