library(shiny)
library(leaflet)

# Choices for drop-downs
vars <- c(
  "Number of records" = "numRecords",
  "Species Richness" = "sppRichness",
  "Genus Richness" = "genRichness",
  "Subfamily Richness" = "subfamRichness"
)

#spp <- sort(unique(antData$scientific_name))


shinyUI(navbarPage("Antweb", id="nav",

  tabPanel("Interactive map",
    div(class="outer",

      tags$head(
        # Include our custom CSS
        includeCSS("styles.css"),
        includeScript("gomap.js")
      ),

      leafletOutput("map", width="100%", height="100%"),

      # Shiny versions prior to 0.11 should use class="modal" instead.
      absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
        draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
        width = 330, height = "auto",

        h2("AntWeb.org explorer"),

        selectInput("size", "Exploration", vars, selected = "numRecords")
        
      ),

      tags$div(id="cite",
        'Data compiled from ', tags$em('AntWeb.org'), ' a project of The California Academy of Sciences.'
      )
    )
  ),
  conditionalPanel("false", icon("crosshair"))
))
