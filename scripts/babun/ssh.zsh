#ensure we don't delegate git ssh handling to PuTTY
unset GIT_SSH

SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "kill $SSH_AGENT_PID" 0
else
    echo "ssh agent not started, maybe clear SSH_AUTH_SOCK"
fi
