
# Create rink plot function
plot_rink = function(p_object){
  
  require(ggforce)
  require(cowplot)
  require(tidyverse)
  
  upper_outline = data.frame(
    x = c(
      115,
      172 + 28*sin(seq(0,pi/2,length=20)),
      172 + 28*sin(seq(pi/2,0,length=20)),
      115
    ),
    y = c(
      0, 
      0 + 28 - 28*cos(seq(0,pi/2,length=20)),
      85 - 28 + 28*cos(seq(pi/2,0,length=20)),
      85
    )
  )
  
  lower_outline = data.frame(
    x = c(
      115,
      100-72 - 28*sin(seq(0,pi/2,length=20)),
      100-72 - 28*sin(seq(pi/2,0,length=20)),
      115
    ),
    y = c(
      0, 
      0 + 28 - 28*cos(seq(0,pi/2,length=20)),
      85 - 28 + 28*cos(seq(pi/2,0,length=20)),
      85
    )
  )
  
  p = p_object +
    ## FACEOFF CIRCLES ##
    geom_circle(data = data.frame(x0 = 100, y0 = 42.5, r = 15), aes(x0 = x0, y0 = y0, r = r), lwd = 0.5, col = "gray50", inherit.aes = FALSE) +
    geom_circle(data = data.frame(x0 = 169, y0 = 20.5, r = 15), aes(x0 = x0, y0 = y0, r = r), lwd = 0.5, col = "gray50", inherit.aes = FALSE) +
    geom_circle(data = data.frame(x0 = 169, y0 = 64.5, r = 15), aes(x0 = x0, y0 = y0, r = r), lwd = 0.5, col = "gray50", inherit.aes = FALSE) +
    geom_circle(data = data.frame(x0 = 31, y0 = 64.5, r = 15), aes(x0 = x0, y0 = y0, r = r), lwd = 0.5, col = "gray50", inherit.aes = FALSE) +
    geom_circle(data = data.frame(x0 = 31, y0 = 20.5, r = 15), aes(x0 = x0, y0 = y0, r = r), lwd = 0.5, col = "gray50", inherit.aes = FALSE) +
    ## FACEOFF DOTS ##
    geom_point(inherit.aes = FALSE, aes(y = 42.5, x = 100), col = "gray50", size = 1) +
    geom_point(inherit.aes = FALSE, aes(y = 20.5, x = 169), col = "gray50", size = 1) +
    geom_point(inherit.aes = FALSE, aes(y = 64.5, x = 169), col = "gray50", size = 1) +
    geom_point(inherit.aes = FALSE, aes(y = 20.5, x = 120), col = "gray50", size = 1) +
    geom_point(inherit.aes = FALSE, aes(y = 64.5, x = 120), col = "gray50", size = 1) +
    geom_point(inherit.aes = FALSE, aes(y = 20.5, x = 31), col = "gray50", size = 1) +
    geom_point(inherit.aes = FALSE, aes(y = 64.5, x = 31), col = "gray50", size = 1) +
    geom_point(inherit.aes = FALSE, aes(y = 20.5, x = 80), col = "gray50", size = 1) +
    geom_point(inherit.aes = FALSE, aes(y = 64.5, x = 80), col = "gray50", size = 1) +
    ## BLUE AND RED LINES ##
    annotate("segment", col = "gray50",  x = 75, xend = 75, y = 0, yend = 85, lwd = 0.5) +
    annotate("segment", col = "gray50", x = 100, xend = 100, y = 0, yend = 85, lwd = 0.5) +
    annotate("segment", col = "gray50",  x = 125, xend = 125, y = 0, yend = 85, lwd = 0.5) +
    ## NET AND GOAL LINE ##
    geom_segment(col = "gray50", inherit.aes = FALSE, lwd = 0.5, aes(y = 79.25, x = 11, yend = 5.75, xend = 11)) +
    geom_segment(col = "indianred", inherit.aes = FALSE, lwd = 0.5, aes(y = 39.5, x = 7.5, yend = 45.5, xend = 7.5)) + 
    geom_segment(col = "indianred", inherit.aes = FALSE, lwd = 0.5, aes(y = 39.5, x = 7.5, yend = 39.5, xend = 11)) +  
    geom_segment(col = "indianred", inherit.aes = FALSE, lwd = 0.5, aes(y = 45.5, x = 7.5, yend = 45.5, xend = 11)) +
    geom_segment(col = "gray50", inherit.aes = FALSE, lwd = 0.5, aes(y = 5.75, x = 189, yend = 79.25, xend = 189)) +
    geom_segment(col = "indianred", inherit.aes = FALSE, lwd = 0.5, aes(y = 39.5, x = 192.5, yend = 45.5, xend = 192.5)) + 
    geom_segment(col = "indianred", inherit.aes = FALSE, lwd = 0.5, aes(y = 39.5, x = 192.5, yend = 39.5, xend = 189)) +  
    geom_segment(col = "indianred", inherit.aes = FALSE, lwd = 0.5, aes(y = 45.5, x = 192.5, yend = 45.5, xend = 189)) +
    ## OUTLINE ##
    geom_path(data = upper_outline, aes(x = x, y = y), colour = "gray80", inherit.aes = FALSE, lwd = 0.5) +
    geom_path(data = lower_outline, aes(x = x, y = y), colour = "gray80", inherit.aes = FALSE, lwd = 0.5) +
    ## ADDITIONAL SPECS ##
    scale_x_continuous(expand = c(0, 0), limits = c(0,200)) + scale_y_continuous(expand = c(0,0), limits = c(0,85)) +
    coord_fixed() +
    theme_void()
  
  return(p)
}

