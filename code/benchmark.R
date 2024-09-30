# Aim: benchmark and record how long it takes to build the book on different setups

remotes::install_cran("benchmarkme")
sys_details = benchmarkme::get_sys_details()
names(sys_details)
sys_details$platform_info
sys_details$r_version
benchmark_df = tibble::tibble(
    command = "bookdown::render_book()",
    date_benchmarked = Sys.time(),
    build_time = NA,
    platform = sys_details$r_version$platform,
    cpu_model = sys_details$cpu$model_name,
    ram = sys_details$ram,
    commit = gert::git_commit_info()$id,
    commit_date = gert::git_commit_info()$time
)

# Remove cache:
unlink("_bookdown_files", recursive = TRUE)
benchmark_build_time = system.time({
    bookdown::render_book()
})
benchmark_df$build_time = benchmark_build_time[3]
benchmark_df$laptop_or_desktop = NA
benchmark_df$comments = NA
benchmarks_previous = readr::read_csv("benchmarks.csv")
benchmarks_updated = rbind(benchmark_df, benchmarks_previous)
readr::write_csv(benchmarks_updated, "benchmarks.csv")
