#jenv uses brew's folder
export JENV_ROOT=/usr/local/opt/jenv

#jenv autocompletion
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

#alternative ways to switch to different default versions of java
alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
alias j17="export JAVA_HOME=`/usr/libexec/java_home -v 17`; java -version"

echo "Use j8/j11/j17 to select default java version through JAVA_HOME. Will now default to Java 8"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
