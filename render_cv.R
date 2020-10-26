# devtools::install_github("nstrayer/datadrivencv")


datadrivencv::use_datadriven_cv(
  full_name = "Gregor Mathes",
  data_location = "https://docs.google.com/spreadsheets/d/1eF2wRaPknohXmXaRA1f9nfOarGwBhp--SqekUtclCww/edit#gid=917338460",
  pdf_location = "https://gregor-mathes.netlify.app/#cv",
  html_location = "https://gregor-mathes.netlify.app/#cv",
  source_location = "https://github.com/Ischi94/CV"
)

# Knit the HTML version
rmarkdown::render("cv.rmd",
                  params = list(pdf_mode = FALSE),
                  output_file = "cv.html")

# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("cv.rmd",
                  params = list(pdf_mode = TRUE),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = "cv.pdf")
