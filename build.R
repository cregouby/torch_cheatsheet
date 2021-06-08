library(chromote) # remotes::install_github("rstudio/chromote")

f <- rmarkdown::render("cheatsheet.Rmd")
b <- ChromoteSession$new()
b$Browser$setWindowBounds(
  windowId = b$Browser$getWindowForTarget()$windowId,
  bounds = list(height = 1080L, width = 1920L)
)

b$Page$navigate(paste0("file://",f))
tmp <- file.path(tempdir(), "torch.png")
b$screenshot(tmp)

img <- magick::image_read(tmp)
magick::image_write(img, "pdf/torch.pdf", format = "pdf")

