ipv4_regex <- "([[:digit:]]+\\.[[:digit:]]+\\.[[:digit:]]+\\.[[:digit:]]+)"
uptime_regex <- "([[:digit:]]+) days, ([[:digit:]]+) hours, ([[:digit:]]+) minutes, ([[:digit:]]+) seconds"

#' Extract uptime from an \code{hping3} output dump
#'
#' Meant for use with output of \code{hping3 --tcp-timestamp -H ips.txt -p PORT -c 2 > output.txt }
#'
#' @param path path to the \code{hping3} output file
#' @param .progress if \code{TRUE} a progress bar will be displayed
#' @export
#' @examples \dontrun{
#' extract_uptime("output.txt")
#' }
extract_uptime <- function(path, .progress=TRUE) {

  hping <- readr::read_lines(path.expand(path))

  starts <- stri_count_regex(hping, "^HPING")

  starts <- which(starts == 1)
  ends <- c((starts[-1]-1), length(hping))

  if (.progress) pb <- progress_estimated(length(starts))

  map2_df(starts, ends, function(start, end) {

    if (.progress) pb$tick()$print()

    hping_rec <- hping[start:end]
    ip <- stri_match_first_regex(hping_rec[1], ipv4_regex)[,2]
    uptime <- which(grepl("System uptime", hping_rec))

    if (length(uptime) > 0) {

      dhms <- stri_match_all_regex(hping_rec[uptime[1]], uptime_regex)[[1]][2:5]
      dhms <- as.numeric(dhms)

      data_frame(ip=ip, days=dhms[1], hours=dhms[2], minutes=dhms[3], seconds=dhms[4])

    } else {

      data_frame(ip=ip, days=NA_real_, hours=NA_real_, minutes=NA_real_, seconds=NA_real_)

    }

  })

}
