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


# Knit the HTML version
rmarkdown::render("cv.rmd",
                  params = list(pdf_mode = FALSE),
                  output_file = "cv.html")

# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("cv_pdf.rmd",
                  params = list(pdf_mode = TRUE),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = "cv.pdf")

# save to website: static folder/ files
# get all files
files <- list.files(path = "~", recursive = TRUE)

# select the path with cv.html
my_path_html <- files[stringr::str_detect(files, "my_website/static/files/cv.html")]

# combine with root
my_path_html <- paste(dirname("~"), basename("~"), my_path_html, sep = "/")

# copy over
file.copy(from = "cv.html", to = my_path_html, overwrite = TRUE)


# same for pdf

my_path_pdf <- files[stringr::str_detect(files, "my_website/static/files/cv.pdf")]

my_path_pdf <- paste(dirname("~"), basename("~"), my_path_pdf, sep = "/")

file.copy(from = "cv.pdf", to = my_path_pdf, overwrite = TRUE)
