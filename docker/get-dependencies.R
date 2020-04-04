# aim: test code to install dependencies for docker images
remotes::install_github("r-hub/sysreqs")
sysreqs::sysreqs(desc = system.file(package = "sf", "DESCRIPTION"), platform = "linux-x86_64-ubuntu-gcc") # works
paste(sysreqs::sysreqs(desc = system.file(package = "tmap", "DESCRIPTION"), platform = "linux-x86_64-ubuntu-gcc"), sep = " ")
reqs = sysreqs::sysreqs(desc = system.file(package = "geocompkg", "DESCRIPTION"), platform = "linux-x86_64-ubuntu-gcc")
reqs_unique = unique(reqs)
msg = paste0("apt install ", paste(reqs_unique, collapse = " "))
# from ghactions in usethis
# cat(sysreqs::sysreq_commands(system.file(package = "sf", "DESCRIPTION"))) # fails as cannot detect OS
cat(sysreqs::sysreq_commands(system.file(package = "sf", "DESCRIPTION"), platform = "linux-x86_64-ubuntu-gcc")) # works!
cat(sysreqs::sysreq_commands(system.file(package = "tmap", "DESCRIPTION"), platform = "linux-x86_64-ubuntu-gcc")) # works!
# export DEBIAN_FRONTEND=noninteractive; apt-get -y update && apt-get install -y libgeos-dev libgeos++-dev gdal-bin libgdal-dev libudunits2-dev pandoc pandoc-citeproc git-core libpng-dev libproj-dev libxml2-dev make libv8-dev default-jre-headless libssl-dev libcurl4-openssl-dev libjq-dev protobuf-compiler libprotoc-dev libprotobuf-dev
cat(sysreqs::sysreq_commands(system.file(package = "mapview", "DESCRIPTION"), platform = "linux-x86_64-ubuntu-gcc")) # works!
# system(msg)
# system2(paste("sudo", msg))
