## docker pull
## git pull
## & 

getwd()

lns = readLines('_git.sh')

for (ln in lns) {
  system(ln)
}