function j_print_usage() {
    VERSIONS=$(ls $SDKMAN_DIR/candidates/java | grep -v current | awk -F'.' '{print $1}' | sort -nr | uniq)
    CURRENT=$(basename $(readlink $JAVA_HOME || echo $JAVA_HOME) | awk -F'.' '{print $1}')
    echo "Available versions: "
    echo "$VERSIONS"
    echo "Current: $CURRENT"
    echo "Usage: j <java_version>"
}

function j() {
  if [[ $# -eq 1 ]]; then
    VERSION_NUMBER=$1
    IDENTIFIER=$(ls $SDKMAN_DIR/candidates/java -1 --color=never | grep -v current | grep "^$VERSION_NUMBER\." | sort -r | head -n 1)
    sdk use java $IDENTIFIER
  else
    j_print_usage
  fi
}

echo "Use 'j [8|11|17]' to select default java version through JAVA_HOME. Will now default to Java 8"

if [ -n "${VSCODE_PID+set}" ]; then
  echo "Skipping SDKman because GUI VScode detected"
else
  #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

  j 8
fi