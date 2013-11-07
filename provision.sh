sudo apt-get update

# install the best database in the world
sudo apt-get install -y postgresql postgresql-contrib libpq-dev

# set default cluster encoding to utf8
sudo pg_dropcluster --stop 9.1 main
sudo pg_createcluster --start 9.1 main --locale=en_US.utf8

# create a vagrant superuser
sudo -u postgres createuser -s vagrant

# install ruby through brightbox repository
sudo apt-get install -y python-software-properties

sudo add-apt-repository -y ppa:brightbox/ruby-ng-experimental
sudo apt-get update
sudo apt-get install -y ruby2.0 ruby2.0-dev ruby2.0-doc

# required stuff & utils
sudo apt-get install -y build-essential git nodejs tmux locate

# configure gem
sudo -u vagrant echo "gem: --no-ri --no-rdoc" >>/home/vagrant/.gemrc
sudo -u vagrant echo 'export GEM_HOME=$HOME/.gem' >>/home/vagrant/.bashrc
sudo -u vagrant echo 'export PATH=$GEM_HOME/bin:$PATH' >>/home/vagrant/.bashrc

# configure tmux
sudo -u vagrant cat <<TMUX >/home/vagrant/.tmux.conf
set -g mode-mouse on
set -g mouse-resize-pane on
set -g mouse-select-pane on
set -g mouse-select-window on
set -s escape-time 0
TMUX
