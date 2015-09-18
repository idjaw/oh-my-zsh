printf '\033[0;34m%s\033[0m\n' "Upgrading Oh My Zsh"
cd "$ZSH"

function _successful_upgrade() {
  printf '\033[0;32m%s\033[0m\n' '         __                                     __   '
    printf '\033[0;32m%s\033[0m\n' '  ____  / /_     ____ ___  __  __   ____  _____/ /_  '
    printf '\033[0;32m%s\033[0m\n' ' / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \ '
    printf '\033[0;32m%s\033[0m\n' '/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / / '
    printf '\033[0;32m%s\033[0m\n' '\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/  '
    printf '\033[0;32m%s\033[0m\n' '                        /____/                       '
    printf '\033[0;34m%s\033[0m\n' 'Hooray! Oh My Zsh has been updated and/or is at the current version.'
    printf '\033[0;34m%s\033[1m%s\033[0m\n' 'To keep up on the latest news and updates, follow us on twitter: ' 'https://twitter.com/ohmyzsh'
    printf '\033[0;34m%s\033[1m%s\033[0m\n' 'Get your Oh My Zsh swag at: ' 'http://shop.planetargon.com/'
}

function _upgrade_failed() {
 printf '\033[0;31m%s\033[0m\n' 'There was an error updating. Try again later?'
}

remote="origin"

if $FORKED_REPO
then
 remote="upstream"
 current_branch="$(git rev-parse --abbrev-ref HEAD)"

 git stash

 if [ "$current_branch" -ne "master" ]
 then
  git checkout master
 fi
fi

if git pull --rebase --stat "$remote" master
then
   _successful_upgrade
  else
  _upgrade_failed
fi

if $FORKED_REPO
then
 if [ "$current_branch" -ne "master" ]
 then
  git checkout "$current_branch"
 fi
 git stash pop
fi
