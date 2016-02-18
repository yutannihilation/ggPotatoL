# ggPotatoL
A prototype of ggHoxoM

```r
devtools::install_github("ggPotatoL")

library(ggplot2)
library(ggPotatoL)

ggplot(data.frame(x = 1:10, y = 1:10), aes(x, y)) +
  geom_potato_l(5,5, size = 3) +
  coord_equal()
```
