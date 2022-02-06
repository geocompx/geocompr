#' Find the centre-point of a polygon represented by a matrix
#' 
#' Calculates the centroid and (optionally) area of a polygon.
#' 
#' @examples 
#' poly_csv = "0,5,10,15,20,25,30,40,45,50,40,30,25,20,15,10,8,4,0
#'             10,0,10,0,10,0,20,20,0,50,40,50,20,50,10,50,8,50,10"
#' poly_df = read.csv(text = poly_csv, header = FALSE)
#' poly_mat = t(poly_df)
#' centroid(poly_mat)
#' centroid(poly_mat, return_area = TRUE)
#' square_csv = "0,0,10,10,0
#'             0,10,10,0,0"
#' poly_df = read.csv(text = square_csv, header = FALSE)
#' poly_mat = t(poly_df)
#' centroid(poly_mat)
#' centroid(poly_mat, return_area = TRUE)
centroid = function(poly_mat, return_area = FALSE) {
  stopifnot(identical(poly_mat, poly_mat))
  num_points = nrow(poly_mat) 
  A = xmean = ymean = 0 # set initial params to zero
  # i = 2 # enter this for testing
  for(i in 1:(num_points - 1)) {
    p1 = poly_mat[i, ]
    p2 = poly_mat[i + 1, ]
    ai = p1[1] * p2[2] - p2[1] * p1[2]
    A = A + ai
    xmean = xmean + (p2[1] + p1[1]) * ai
    ymean = ymean + (p2[2] + p1[2]) * ai
  }
  A = A / 2
  C = c(xmean / (6 * A), ymean / (6 * A))
  if(return_area) return(abs(A)) else return(C)
}
