library(sf)
# centroid calculation with Python:
dir.create("py")
download.file("https://github.com/gisalgs/geom/archive/master.zip", "py/gisalgs.zip")
unzip("py/gisalgs.zip", exdir = "py/")
file.rename(from = "py/geom-master", to = "py/geom")
file.copy("py/geom/__init__.py", "py/")
library(reticulate)
reticulate::py_config()
# use_python("/usr/bin/python3")
res = py_run_string("x = 1 +3")
res$x
py_run_string("import os")
py_run_string("sys.path.append('/home/robin/repos/geocompr/py')")
py_run_string("from geom.point import *")
res = py_run_string("p, p1, p2 = Point(10,0), Point(0,100), Point(0,1)")
res$p1
py_run_string("print(p.distance(p1))")
res = py_run_file("py/geom/centroid.py")
points_py = res$points
mat_points = matrix(unlist(points_py), ncol = 2, byrow = TRUE)
plot(mat_points)
poly_csv = "0,5,10,15,20,25,30,40,45,50,40,30,25,20,15,10,8,4,0
            10,0,10,0,10,0,20,20,0,50,40,50,20,50,10,50,8,50,10"
poly_df = read.csv(text = poly_csv, header = FALSE)
poly_mat = t(poly_df)
poly_sf = st_polygon(x = list(mat_points))
plot(poly_sf)
# access modules
g = import_from_path(module = 'geom', '/home/robin/repos/geocompr/py')
g$point
unlink("py", recursive = TRUE)
