FROM=$1
WHERE=$2

if [[ -z $WHERE ]]; then
  WHERE=$PWD
fi

echo "installing $FROM into $WHERE"

# CHECK GIT REPOSITORY
if [[ -d "$WHERE/.git" ]]; then

  # GERRIT COMMIT HOOK
  if [[ -f "$WHERE/.git/hooks/commit-msg" ]]; then
    echo "Commit Hook ok"
  else
    echo -n "Do you want to install couchbase gerrit review commit hook (y/n)? "
    read yesno
    if [[ "$yesno" == "y" ]]; then
      cp "$FROM/commit-msg" "$WHERE/.git/hooks/commit-msg"
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

      echo "git remote add $remote ssh://simonbasle@review.couchbase.org:29418/${reponame}.git"
    else
      echo "gerrit remote skipped"
    fi
  fi
else
    echo "Not a Git repository: $WHERE"
fi

#cleanup
unset WHERE
unset FROM
unset hasgerrit
unset reponame
unset defreponame
unset remote
unset yesno
