# aliases for zsh
alias topdirs='du -h | sort -hr | head'
alias topfiles='du -axh . | sort -nr | head'
alias move='rsync -ahP --remove-source-files --progress '

#ls related
alias ls='ls --color'
alias l='ls -lh'
alias ll='ls -la'

#grep-related
alias -g G='| grep'
alias falias='alias | grep'

#git aliases
git config --global alias.lg "log --color --graph --pretty=format:'%C(dim red)%h%Creset - %C(blue black)%s%Creset %C(white yellow)%d%Creset (%Cgreen%cr %Creset%an)' --abbrev-commit"
git config --global alias.changelog '!git shortlog -esn $1 $2 $3 && git log --reverse --pretty=format:"%s%x09%x09%h" $1 $2 $3'

#maven: install a source or javadoc into local repo
function mvngetsource() {
	mvn org.apache.maven.plugins:maven-dependency-plugin:get -Dartifact=$1:$2:$3:jar:sources
}
function mvngetdoc() {
	mvn org.apache.maven.plugins:maven-dependency-plugin:get -Dartifact=$1:$2:$3:jar:javadoc
}
function mvngetall() {
	mvn org.apache.maven.plugins:maven-dependency-plugin:get -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dpackaging=jar
	mvn org.apache.maven.plugins:maven-dependency-plugin:get -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dpackaging=jar -Dclassifier=sources
	mvn org.apache.maven.plugins:maven-dependency-plugin:get -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dpackaging=jar -Dclassifier=javadoc
	mvn org.apache.maven.plugins:maven-dependency-plugin:get -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dpackaging=pom
}

#maven quickstart
alias mvnquick='mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart'

#gitignore.io gitignore tool
function gi() {
	curl -L -s https://www.gitignore.io/api/$@ ;
}

#nicer presentation of mount
function nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ; }

#get current dir (only last dir)
function pwdd() {
  result=${PWD##*/}          # to assign to a variable
  #printf '%s\n' "${PWD##*/}" # to print to stdout
                           # ...more robust than echo for unusual names
                           #    (consider a directory named -e or -n
  printf '%q\n' "${PWD##*/}" # to print to stdout, quoted for use as shell input
                           # ...useful to make hidden characters readable.
}


HELP_DOTFILES+=("topdirs" "list biggest dirs in current directory (see also topfiles)")
HELP_DOTFILES+=("move file1 fil2 dest" "rsync move the$YELLOW files$RESET to$CYAN dest$RESET, with a progress bar")
HELP_DOTFILES+=("nicemount" "more readable version of mount list" "falias" "grep the alias list for a specific word" "G" "global alias, pipes a grep")
HELP_DOTFILES+=("pwdd" "shows current directory (not full path), quoted")
HELP_DOTFILES+=("mvngetsource" "load sources for$YELLOW groupId artifactId version$RESET into maven repo")
HELP_DOTFILES+=("mvngetdoc" "load javadocs for$YELLOW groupId artifactId version$RESET into maven repo")
HELP_DOTFILES+=("mvngetall" "load jar+sources+javadoc+pom for$YELLOW groupId artifactId version$RESET into maven repo")
HELP_DOTFILES+=("git changelog TAG..BRANCH [optionalParam1] [optionalParam2] " "author list followed by oneline changelog for commits between$YELLOW TAG$RESET and$CYAN BRANCH$RESET (subject and sha1)")
