# This is newer version of _record_speed.csv
uptime <- function(unit = 'second'){
  # only for linux?
  since <- system('uptime -s',intern = TRUE)  |>
    lubridate::ymd_hms(tz = Sys.timezone())
  
  interval(since,now(tzone = Sys.timezone())) |>
    lubridate::time_length(unit = unit)
}

uptime_min = tryCatch(uptime(unit='minute'), error=function(e) {NA})

# project의 root directory로 찾아가기???

bookname = yaml::read_yaml('_bookdown.yml')$book_filename

cat('* Build Book to ', paste0(bookname, '.pdf'), '\n')

if (file.exists(file.path('_book', 
                          paste0(bookname, '.pdf')))) {
  cat(' - pdf found, deleting...')
  delete_success = file.remove(file.path('_book', 
                               paste0(bookname, '.pdf')))
  if (!delete_success) {
    cat('\n')
    stop(paste0(file.path('_book', 
                          paste0(bookname, '.pdf')), ' could not be deleted!'))
  } else {
    cat(paste0(rep('\b', 11), collapse=''))
    cat('deleted           \n')
  }
}


sysinfo = Sys.info()
sysinfo['sysname']
sysinfo['version']
sysinfo['machine']

# install.packages('memuse')
meminfo=memuse::Sys.meminfo()
#str(cpuinfo)
mem_total = paste(round(meminfo$totalram@size, 2), meminfo$totalram@unit)
mem_free = paste(round(meminfo$freeram@size, 2), meminfo$freeram@unit)

# install.packages('ps')
# ps::ps()[ps::ps()$name == "rsession",]

library(benchmarkme)
# install.packages('benchmarkme')
cpuinfo = get_cpu()
cpu_vendor = cpuinfo$vendor_id
cpu_model = cpuinfo$model_name
cpu_ncores = cpuinfo$no_of_cores

t0 = Sys.time()
# render_book() 
# # Error: bookdown::render_book() failed to render the output format 'bookdown::pdf'.
# render_book(output_format = bookdown::pdf_book()) 
# 여전히 ERROR
bookdown::render_book(output_format = "bookdown::pdf_book")
t1 = Sys.time()
#dt = as.difftime(t1 - t0, units='mins') # 주의!!!
dt = as.numeric(difftime(t1, t0, units='mins'))

bookname = yaml::read_yaml('_bookdown.yml')$book_filename
if (file.exists(file.path('_book', 
                          paste0(bookname, '.pdf')))) {
  build_success = TRUE
} else {
  build_success = FALSE
}




library(readr)


dat = data.frame(datetime = format(Sys.time(), "%Y-%m-%d %H:%M:%S", tz="Asia/Seoul"), 
                 machine = sysinfo['machine'],
                 cpu_vendor = cpu_vendor,
                 cpu_model = cpu_model,
                 cpu_ncores = cpu_ncores,
                 mem_total = mem_total,
                 mem_free = mem_free,
                 sys_name = sysinfo['sysname'],
                 sys_ver =sysinfo['version'],
                 build_success = build_success,
                 time_elapsed = as.numeric(dt) # mins
)

dat = data.frame(datetime = format(Sys.time(), "%Y-%m-%d %H:%M:%S", tz="Asia/Seoul"), 
                 machine = sysinfo['machine'],
                 cpu_vendor = cpu_vendor,
                 cpu_model = cpu_model,
                 cpu_ncores = cpu_ncores,
                 mem_total = mem_total,
                 mem_free = mem_free,
                 sys_name = sysinfo['sysname'],
                 sys_ver =sysinfo['version'],
                 build_success = build_success,
                 time_elapsed = as.numeric(dt), # mins
                 uptime_min = uptime_min
)

## Error나 Warning 메시지도 기록해야?

if (file.exists("_build_book_speed.csv")) {

  tryCatch({
    dat0 = read.csv("_build_book_speed.csv")
    datAll = rbind(dat0, dat)
    write_csv(datAll, "_build_book_speed.csv")},
    error = function(e) {
      cat('!E error during [combine & write] to _build_book_speed.csv\n')
      stop(e)
    })
} else {
  write_csv(dat, 
            "_build_book_speed.csv")
}


## 근데 총 원고의 양에 따라 달라지므로
## 그걸 고려해야 할 듯?



#' 
#' #' Function to get system uptime. 
#' #' 
#' #' @param round Should the dates and times be rounded to the nearest second? 
#' #' 
#' #' @param as.vector Should the return be a single numeric value indicating 
#' #' seconds since boot time? This is the most efficient way to get this value and 
#' #' is suitable for multiple/continuous calling in a logging application.  
#' #' 
#' #' @author Stuart K. Grange
#' #' 
#' #' @return Tibble or numeric vector. 
#' #' 
#' #' @export
#' system_uptime <- function(round = TRUE, as.vector = FALSE) {
#'   
#'   if (!require('hms'))
#'   
#'   # Simple and efficient return
#'   if (as.vector) {
#'     
#'     text <- readLines("/proc/uptime", warn = FALSE)
#'     seconds <- stringr::str_split_fixed(text, " ", 2)[, 1]
#'     seconds <- as.numeric(seconds)
#'     if (round) seconds <- round(seconds)
#'     return(seconds)
#'     
#'   } 
#'   
#'   # Get time system has been up
#'   date_system <- lubridate::now()
#'   
#'   # Get and clean uptime
#'   text <- readLines("/proc/uptime", warn = FALSE)
#'   seconds <- stringr::str_split_fixed(text, " ", 2)[, 1]
#'   seconds <- as.numeric(seconds)
#'   
#'   if (round) {
#'     
#'     date_system <- round(date_system)
#'     seconds <- round(seconds) 
#'     
#'   }
#'   
#'   # Boot time
#'   date_up <- date_system - seconds
#'   
#'   # Different date types
#'   date_interval <- lubridate::interval(date_up, date_system)
#'   date_period <- lubridate::as.period(date_interval)
#'   date_hms <- hms::as.hms(seconds)
#'   
#'   # Format
#'   date_system <- format(date_system, usetz = TRUE)
#'   date_up <- format(date_up, usetz = TRUE)
#'   date_period <- format(date_period)
#'   date_hms <- format(date_hms)
#'   
#'   # Build data frame
#'   df <- tibble(
#'     date_up,
#'     date_system, 
#'     seconds_up = seconds,
#'     period_up = date_period,
#'     hms_up = date_hms
#'   )
#'   
#'   return(df)
#'   
#' }
#' 
#' 
