#CREDIT TO PLOTLY
#Plotly is a free and open-source graphing library for R.
#We recommend you read our Getting Started guide for the latest installation
#or upgrade instructions, then move on to our Plotly Fundamentals tutorials
# or dive straight in to some Basic Charts tutorials.

#See https://plot.ly/r/graphing-multiple-chart-types/

library(plotly)

#Scatterplot with Loess Smoother

fig <- plot_ly(mtcars, x = ~disp, color = I("black"))
fig <- fig %>% add_markers(y = ~mpg, text = rownames(mtcars), showlegend = FALSE)
fig <- fig %>% add_lines(y = ~fitted(loess(mpg ~ disp)),
            line = list(color = '#07A4B5'),
            name = "Loess Smoother", showlegend = TRUE)
fig <- fig %>% layout(xaxis = list(title = 'Displacement (cu.in.)'),
         yaxis = list(title = 'Miles/(US) gallon'),
         legend = list(x = 0.80, y = 0.90))

#save graph in pdf
pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Output/loess_intro2_Figure.pdf")

fig

#Loess Smoother with Uncertainty Bounds
#install.packages("broom")

library(plotly)
library(broom)

m <- loess(mpg ~ disp, data = mtcars)

fig <- plot_ly(mtcars, x = ~disp, color = I("black"))
fig <- fig %>% add_markers(y = ~mpg, text = rownames(mtcars), showlegend = FALSE)
fig <- fig %>% add_lines(y = ~fitted(loess(mpg ~ disp)),
            line = list(color = 'rgba(7, 164, 181, 1)'),
            name = "Loess Smoother")
fig <- fig %>% add_ribbons(data = augment(m),
              ymin = ~.fitted - 1.96 * .se.fit,
              ymax = ~.fitted + 1.96 * .se.fit,
              line = list(color = 'rgba(7, 164, 181, 0.05)'),
              fillcolor = 'rgba(7, 164, 181, 0.2)',
              name = "Standard Error")
fig <- fig %>% layout(xaxis = list(title = 'Displacement (cu.in.)'),
         yaxis = list(title = 'Miles/(US) gallon'),
         legend = list(x = 0.80, y = 0.90))

fig



