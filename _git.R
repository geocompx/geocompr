## docker pull
## git pull
## & 

getwd()

lns = readLines('_git.sh')

for (ln in lns) {
  cat(paste('$ ', ln, '\n', collapse=""))
  scan()
  system(ln)
}