#!/bin/bash
#
# setup pixiebox proxies
#


##
## functions
##
project_root() {
  slashes=${PWD//[^\/]/}
  directory="$PWD"
  for (( n=${#slashes}; n>0; --n ))
  do
    test -e "$directory/.pixiebox" && echo "$directory/.pixiebox" && return
    directory="$directory/.."
  done
}

can_execute () {
  if [ -e "$(project_root)/project.ini" ]; then
    true
  else
    false
  fi
}

pixiebox_proxy () {
  if can_execute; then
    docker-compose exec "${@}"
  else
    if [ "$ZSH_NAME" ]; then
      `whence -p "$2"` "${@:3}"
    else
      `type -P "$2"` "${@:3}"
    fi
  fi
}

#pixiebox_cmd() {
#  case "${@[1]}" in
#    rails)
#      cmd=(dev bundle exec rails "${@:2}")
#      ;;
#    *)
#      echo "dunno"
#  esac
#
#  pixiebox_proxy ${cmd[@]}
#}

##
## ruby proxies
##
pixiebox_gem ()    { cmd=(dev gem $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_rake ()   { cmd=(dev rake $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_bundle () { cmd=(dev bundle $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_irb()     { cmd=(dev irb $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_ruby()    { cmd=(dev ruby $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_rackup()  { cmd=(dev rackup $@) ; pixiebox_proxy ${cmd[@]} ; }

alias pb-gem=pixiebox_gem
alias pb-rake=pixiebox_rake
alias pb-bundle=pixiebox_bundle
alias pb-irb=pixiebox_irb
alias pb-ruby=pixiebox_ruby
alias pb-rackup=pixiebox_rackup


###
## rails proxies
##
pixiebox_rails ()   { cmd=(dev bundle exec rails $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_spring ()  { cmd=(dev bundle exec spring $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_yarn ()    { cmd=(dev bundle exec yarn $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_sidekiq () { cmd=(dev bundle exec sidekiq $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_guard ()   { cmd=(test bundle exec guard $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_rspec ()   { cmd=(test bundle exec rspec $@) ; pixiebox_proxy ${cmd[@]} ; }

pixiebox_webpack ()           { cmd=(dev bin/webpack $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_webpack_dev_server() { cmd=(dev bin/webpack-dev-server $@) ; pixiebox_proxy ${cmd[@]} ; }


alias pb-rails=pixiebox_rails
alias pb-rspec=pixiebox_rspec
alias pb-spring=pixiebox_spring
alias pb-yarn=pixiebox_yarn
alias pb-sidekiq=pixiebox_sidekiq
alias pb-webpack=pixiebox_webpack
alias pb-webpack-dev-server=pixiebox_webpack_dev_server
alias pb-guard=pixiebox_guard

##
## redis proxies
##
pixiebox_redis_cli () { cmd=(redis redis-cli $@) ; pixiebox_proxy ${cmd[@]} ; }

alias pb-redis-cli=pixiebox_redis_cli

##
## postgres proxies
##
pixiebox_psql () { cmd=(postgres psql $@) ; pixiebox_proxy ${cmd[@]} ; }

alias pb-psql=pixiebox_psql

##
## mysql proxies
##
pixiebox_mysql () { cmd=(mysql mysql $@) ; pixiebox_proxy ${cmd[@]} ;}

alias pb-mysql=pixiebox_mysql


##
## elixir proxies
##
pixiebox_elixir() { cmd=(dev elixir $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_mix()    { cmd=(dev mix $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_iex()    { cmd=(dev iex $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_erl()    { cmd=(dev erl $@) ; pixiebox_proxy ${cmd[@]} ; }

alias pb-elixir=pixiebox_elixir
alias pb-mix=pixiebox_mix
alias pb-iex=pixiebox_iex
alias pb-erl=pixiebox_erl


##
## python proxies
##
pixiebox_python() { cmd=(dev python $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_pip()    { cmd=(dev pip $@) ; pixiebox_proxy ${cmd[@]} ; }

alias pb-python=pixiebox_python
alias pb-pip=pixiebox_pip


##
## node proxies
##
pixiebox_npm()    { cmd=(dev npm $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_nodejs() { cmd=(dev nodejs $@) ; pixiebox_proxy ${cmd[@]} ; }
pixiebox_node()   { cmd=(dev node $@) ; pixiebox_proxy ${cmd[@]} ; }

alias pb-npm=pixiebox_npm
alias pb-nodejs=pixiebox_nodejs
alias pb-node=pixiebox_node


##
## backstop proxies
##

alias pb-backstop='docker run --rm -v $(pwd):/src backstopjs/backstopjs "$@"'
