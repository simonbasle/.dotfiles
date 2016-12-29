eval export DOCKER_TLS_VERIFY="1" export DOCKER_HOST="tcp://192.168.99.100:2376" export DOCKER_CERT_PATH="/Users/edralzar/.docker/machine/machines/default" export DOCKER_MACHINE_NAME="default" # Run this command to configure your shell: # eval $(docker-machine env default)

export PATH=$PATH:~/dev/go/gosource/bin

# set the default Java to JDK 1.8
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

#used to source homebrew github access token HOMEBREW_GITHUB_API_TOKEN
#previous committed one was revoked, moved to uncomitted ../common/private.zsh
