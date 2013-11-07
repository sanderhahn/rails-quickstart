# Start and Provision Virtual Machine

```bash
vagrant up
```

The `provision.sh` installs ruby, rails and the postgres database.
The provisioning might take some time.

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
Switch between the shells by pressing Ctrl-B and up/down arrow.
In the first shell i run the server and watching the log and in
the second shell i run rails and shell commands.

# Scaffold Blog Post

```bash
rails generate scaffold Post title:string text:text
rake db:migrate
```

# Start Server

```
rails server
```

Open a webbrowser and navigate to `http://localhost:3000/posts`.

# References

[Rails API](http://api.rubyonrails.org/)
[Postgres Docs](http://www.postgresql.org/docs/9.1/interactive/index.html)
[Vagrant Docs](http://docs.vagrantup.com/v2/)

# Save Source in Github or Bitbucket

Use git on your local machine:

```
git config --global user.name "Your Name"
git config --global user.email "yourname@domain.com"

git init
git add -A
git commit -m 'initial commit'

git remote add origin ssh://git@bitbucket.org/yourname/yourrepo.git
git push -u origin
```

# Backup Database

```bash
pg_dump blog_development >blog_backup.sql
```

# Cleanup the VM

```bash
vagrant destroy
```
