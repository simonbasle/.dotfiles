FROM=$1
WHERE=$2

echo $WHERE

if [[ -z $WHERE ]]; then
  WHERE=$PWD
fi

echo "installing $FROM into $WHERE"

# CHECK GIT REPOSITORY
if [[ -d "$WHERE/.git" ]]; then

  # GERRIT COMMIT HOOK
  if [[ -f "$WHERE/.git/hooks/commit-msg-hook" ]]; then
    echo "Commit Hook ok"
  else
    echo -n "Do you want to install couchbase gerrit review commit hook (y/n)? "
    read yesno
    if [[ "$yesno" == "y" ]]; then
      cp "$FROM/commit-msg-hook" "$WHERE/.git/hooks/commit-msg"
      chmod +x "$WHERE/.git/hooks/commit-msg"
      echo "Commit Hook installed"
    else
      echo "Commit Hook skipped"
    fi
  fi

  # ENSURE GERRIT REMOTE
  hasgerrit=`git config -l | grep remote | grep url | grep review.couchbase.org | cut -d\. -f2`
  if [[ -n $hasgerrit ]]; then
    echo "Gerrit URL found in remote $hasgerrit"
  else
    echo -n "Do you want to add gerrit remote (y/n)? "
    read yesno
    if [[ "$yesno" == "y" ]]; then
      echo -n "enter a name for remote [gerrit]: "
      read remote
      if [[ -z $remote ]]; then remote="gerrit"; fi

      defreponame=`pwdd`
      echo -n "confirm git repo name [$defreponame]: "
      read reponame
      if [[ -z $reponame ]]; then reponame=$defreponame; fi

      git remote add $remote ssh://simonbasle@review.couchbase.org:29418/${reponame}.git
      hasgerrit="$remote"
      echo "gerrit remote added as $remote"
    else
      echo "gerrit remote skipped"
    fi
  fi

  # REVIEW ALIAS
  if [[ -n $hasgerrit ]]; then
    echo -n "Gerrit remote '$hasgerrit' found, do you want to add 'git review' alias for submitting master branch to review?"
    read yesno
    if [[ "$yesno" == "y" ]]; then
      git config alias.review "push $hasgerrit HEAD:refs/for/master"
    else
      echo "git review alias skipped"
    fi
  fi

  # INSTALL COMMIT MESSAGE TEMPLATE
  echo -n "Install commit template? "
  read yesno
  if [[ "$yesno" == "y" ]]; then
    git config --local commit.template "$FROM/commit-msg.txt"
    echo "commit template installed"
  fi
else
    echo "Not a Git repository: $WHERE"
fi

#cleanup
unset WHERE
unset FROM
unset hasgerrit
unset hasalias
unset reponame
unset defreponame
unset remote
unset yesno
