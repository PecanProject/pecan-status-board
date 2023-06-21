library(rpecanapi)
library(dplyr)
library(tidyr)
library(tibble)
library(purrr)
library(httr)
library(glue)


# Submit a workflow in XML format for execution
xmlFile <- "inst/test-data/api.sipnet.xml"
xml_string <- paste0(xml2::read_xml(xmlFile))
url <- "http://172.17.0.1/api/workflows/"
username <- "carya"
password <- "illinois"

headers <- c("Host" = "pecan.localhost")
auth <- authenticate(username, password)

res <- POST(
  url,
  authenticate = auth,
  content_type("application/xml"),
  add_headers(.headers = headers),
  body = xml_string
)
print(jsonlite::fromJSON(rawToChar(res$content)))
