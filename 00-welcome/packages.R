# Install packages that will be used in the workshop
from_cran <- c("DT", "glue", "flexdashboard", "rmarkdown", "shiny", 
               "shinydashboard", "shinythemes", "tidyverse")

install.packages(from_cran, repos = "http://cran.rstudio.com")


# Load packages

library(DT)
library(glue)
library(flexdashboard)
library(rmarkdown)
library(shiny)
library(shinydashboard)
library(shinythemes)
library(tidyverse)
