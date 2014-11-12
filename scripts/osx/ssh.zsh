# If no SSH agent is already running, start one now. Re-use sockets so we never
# have to start more than one session.
function ssh-start() {
  echo "ssh-start : check if ssh-agent should be started"
  ssh-add -l >/dev/null 2>&1
  if [ $? -gt 0 ]; then
     # No ssh-agent running
     rm -rf $SSH_AUTH_SOCK
     # force to reuse same AUTH SOCKET
     export SSH_AUTH_SOCK=~/.ssh/.ssh-socket
     # >| allows output redirection to over-write files if no clobber is set
     ssh-agent -a $SSH_AUTH_SOCK >| /tmp/.ssh-script
     source /tmp/.ssh-script
     echo $SSH_AGENT_PID >| ~/.ssh/.ssh-agent-pid
     rm /tmp/.ssh-script
     echo "ssh agent running as PID $SSH_AGENT_PID"
  else
    echo -n "ssh agent detected with probable PID "
    cat ~/.ssh/.ssh-agent-pid
  fi
}

ssh-start
