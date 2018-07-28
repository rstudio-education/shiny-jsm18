# Shiny Essentials

[JSM 2018](http://ww2.amstat.org/meetings/jsm/2018/)  
Sat, Jul 28, 8:00 AM - 4:00 PM  
CC-East 11  

## Description

Shiny is an R package that makes it easy to build interactive web apps straight 
from R. You can host stand-alone apps on a webpage or embed them in R Markdown 
documents or build dashboards. This short course will introduce you to building 
web applications and dashboards with Shiny, reactive programming, and customizing 
and deploying your apps for others to use. Please bring a laptop with you.

## Slides

0 - [Welcome](https://github.com/rstudio-education/shiny-jsm18/blob/master/00-welcome/00-welcome.pdf)  
1 - [Getting started](https://github.com/rstudio-education/shiny-jsm18/blob/master/01-getting-started/01-getting-started.pdf)  
2 - [Understanding reactivity](https://github.com/rstudio-education/shiny-jsm18/blob/master/02-understand-reactivity/02-understand-reactivity.pdf)  
3 - [Designing UI](https://github.com/rstudio-education/shiny-jsm18/tree/master/03-design-ui)  
4 - [Dashboards](https://github.com/rstudio-education/shiny-jsm18/blob/master/04-dashboards/04-dashboards.pdf)  

## Logistics

### Equipment

Please bring a laptop with a web browser and a power cord.

### Setup

#### Option 1: RStudio Cloud :cloud:

I have set up an RStudio Cloud space for the workshop, with all the packages 
you will need pre-installed. The space will also include all the starter code 
you will need for the exercises.

If you choose to use this space, you should not need to install any software 
or packages (and you don’t need to worry about the rest of the instructions 
listed below).

#### Option 2: Local Installation :computer:

However if you would like to use your own setup, please make sure that you have 
R and RStudio installed.

  - R - 3.5.0 above: https://cran.r-project.org/
  - RStudio - 1.2.247 or above: https://www.rstudio.com/products/rstudio/download/preview/

It is also recommended that you pre-install the packages we will use at the 
workshop. The package installation instructions are as follows

```
# Install

from_cran <- c("DT", "glue", "flexdashboard", "rmarkdown", "shiny", 
               "shinydashboard", "shinythemes", "tidyverse")

install.packages(from_cran, repos = "http://cran.rstudio.com")

# Load

library(DT)
library(glue)
... # load the remaining packages similarly
```

The install.packages command may install additional packages, which can take 
some time. Hence it is recommended that you install them ahead of time, 
if possible.

If you will be using your own setup, and especially if you have never used 
Shiny before, please try the following before you arrive:

In RStudio, go to File :arrow_right: New File :arrow_right: Shiny Web App to 
create a new Shiny app, and click on the Run App button. If this works without 
any issues, you’re ready to go!
