# This script builds both the HTML and PDF versions of your CV

# If you wanted to speed up rendering for googlesheets driven CVs you could use
# this script to cache a version of the CV_Printer class with data already
# loaded and load the cached version in the .Rmd instead of re-fetching it twice
# for the HTML and PDF rendering. This exercise is left to the reader.

# devtools::install_github("nstrayer/datadrivencv")

# set up once

# datadrivencv::use_datadriven_cv(
#   full_name = "Gregor Mathes",
#   data_location = "https://docs.google.com/spreadsheets/d/1eF2wRaPknohXmXaRA1f9nfOarGwBhp--SqekUtclCww/edit#gid=917338460",
#   pdf_location = "https://github.com/Ischi94/CV/blob/master/cv.pdf",
#   html_location = "https://gregor-mathes.netlify.app/#cv",
#   source_location = "https://github.com/Ischi94/CV"
# )


# add data science writing first
# Knit the HTML version
rmarkdown::render("cv.rmd",
                  params = list(pdf_mode = FALSE),
                  output_file = "cv.html")

# comment out data science writing first
# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("cv.rmd",
                  params = list(pdf_mode = TRUE),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = "cv.pdf")

# save to static folder/ files