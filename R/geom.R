#' Geom for hoxo_m
#'
#' This is not about Potato L
#'
#' @examples
#' library(ggplot2)
#'
#' ggplot(data.frame(x = 1:10, y = 1:10), aes(x, y)) +
#'   annotate_potato_l(5,5, size = 3) +
#'   coord_equal()
#'
#' @export
annotate_potato_l <- function(x, y, size = 5, interpolate = FALSE, ...){
  ggplot2::layer(
    data = NULL,
    mapping = NULL,
    stat = ggplot2::StatIdentity,
    position = ggplot2::PositionIdentity,
    geom = GeomPotatoL,
    inherit.aes = TRUE,
    params = list(
      x = x,
      y = y,
      size = size,
      interpolate = interpolate
    )
  )
}

get_image <- function(){
  res <- memoise::memoise(httr::GET)(
    "https://pbs.twimg.com/profile_images/643415285773414401/GGklYhgo.jpg"
  )
  grDevices::as.raster(httr::content(res))
}

#' @export
GeomPotatoL <-  ggplot2::ggproto(
  "GeomPotatoL",
  ggplot2::Geom,
  handle_na = function(data, params) {
    data
  },
  default_aes = ggplot2::aes(size = 5),
  draw_panel = function(data, panel_scales, coord,
                        x, y, size, interpolate = FALSE) {
    if (!inherits(coord, "CoordCartesian")) {
      stop("geom_potato_l only works with Cartesian coordinates",
           call. = FALSE)
    }
    corners <- data.frame(x = c(x - size/2, x + size/2), y = c(y - size/2, y + size/2))
    data <- coord$transform(corners, panel_scales)

    x_rng <- range(data$x, na.rm = TRUE)
    y_rng <- range(data$y, na.rm = TRUE)

    raster <- get_image()

    grid::rasterGrob(raster, x_rng[1], y_rng[1],
                     diff(x_rng), diff(y_rng), default.units = "native",
                     just = c("left","bottom"), interpolate = interpolate)
  }
)
