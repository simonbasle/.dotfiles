#ensure we don't delegate git ssh handling to PuTTY
unset GIT_SSH

# If no SSH agent is already running, start one now. Re-use sockets so we never
# have to start more than one session.

ssh-add -l >/dev/null 2>&1
if [ $? = 2 ]; then
   # No ssh-agent running
   rm -rf $SSH_AUTH_SOCK
   # force to reuse same AUTH SOCKET
   export SSH_AUTH_SOCK=~/.ssh-socket
   # >| allows output redirection to over-write files if no clobber is set
   ssh-agent -a $SSH_AUTH_SOCK >| /tmp/.ssh-script
   source /tmp/.ssh-script
   echo $SSH_AGENT_PID >| ~/.ssh-agent-pid
   rm /tmp/.ssh-script
   echo "ssh agent running as PID $SSH_AGENT_PID"
fi