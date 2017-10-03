\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3.3
echo “source ~/.profile” >> ~/.bash_profile
source ~/.bash_profile
rvm use 2.3.3


[7:44]
#.bash_profile
if which rbenv > /dev/null; then eval “$(rbenv init -)“; fi

[[ -s “$HOME/.rvm/scripts/rvm” ]] && source “$HOME/.rvm/scripts/rvm” # Load RVM into a shell session *as a function*
source ~/.profile
gem install -v 4.2.7