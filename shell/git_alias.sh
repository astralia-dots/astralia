# GIT ALIASES & FUNCTIONS

typeset -A _git_aliases=(
  ga   "add"
  gaa  "add -A"
  gb   "branch"
  gcm  "commit -m"
  gco  "checkout"
  gd   "diff"
  glog "log --oneline --graph --decorate"
  gp   "push"
  gpr  "pull --rebase"
  gs   "status"
)

for _a _cmd in "${(kv)_git_aliases[@]}"; do
  alias "$_a"="git $_cmd"
done
unset _a _cmd _git_aliases

gf() {
  git add -A
  git commit -m update
  git push
}
