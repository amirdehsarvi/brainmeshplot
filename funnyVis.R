library(rayshader)
library(reshape2)


sinSample <- function(minFreq, maxFreq, freqReduceFactor, nSample){
  ran <- seq(1, freqReduceFactor, length.out = nSample)
  sapply(ran, function(rf){
    dist <- (maxFreq-minFreq)/rf
    sin(seq(from = -dist, to = dist, length.out = nSample))+1
  })
}

mat <- sinSample(-10,10, 5, 200)
lMat <- melt(mat)
attr(lMat, "extent") <- raster(mat)@extent
matFlat <- matrix(0, nrow(mat), ncol(mat))


# #We use another one of rayshader's built-in textures:
# mat %>%
#   sphere_shade(texture = "desert") %>%
#   plot_map()



mat %>%
  plot_3d(matFlat, zscale = 0.1, fov = 0, theta = -45, phi = 45,
          windowsize = c(1500, 1500), zoom = 0.75,
          baseshape = "rectangle",
          hillshade = matrix(runif(do.call(`*`, as.list(dim(mat)))), nrow(mat), ncol(mat)))

ndim=nrow(mat)
render_points(
  extent = raster(mat)@extent,
  lat = rev(lMat$Var2/ndim),
  long = lMat$Var1/ndim,
  heightmap = mat,
  altitude = NULL,
  zscale = 0.1,
  size = 5,
  color = "black",
  offset = .1,
  clear_previous = FALSE
)


for(i in seq(ndim)){
  render_path(extent = raster(mat)@extent,
              lat = rev(rep(i/ndim, ndim)), long = seq(0, ndim/ndim, length.out = ndim),
              altitude = NULL, heightmap = mat, zscale=0.1,color="red", antialias=FALSE, offset = 0.1, linewidth = 3)
}

# Sys.sleep(0.2)
# render_snapshot(clear=TRUE)

# render_highquality(filename = "Brigels.png", samples=200,  clear=TRUE)
render_highquality(filename = "test.png",
                   samples = 100,
                   line_radius = 1,
                   sample_method="stratified",
                   clear=TRUE)
