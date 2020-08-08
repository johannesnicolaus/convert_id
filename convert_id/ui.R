
library(shiny)

file_input <- fileInput("file1", "Choose csv File",
                        accept = c(
                            "text/csv",
                            "text/comma-separated-values,text/plain",
                            ".csv")
)


organism_input <- selectInput("organism", "Organism:",
                              c("Human" = "hsapiens",
                                "Mouse" = "mmusculus",
                                "Chicken" = "ggallus"))

keytype_input <- selectInput("keytype", "Type of ID supplied:",
                              c("Ensembl gene id" = "ensembl_gene_id",
                                "Ensembl transcript id" = "ensembl_transcript_id",
                                "External gene id" = "external_gene_id"))

host_input <- selectInput("host", "Ensembl host (only use when default doesn't work):",
                          selected = "asia.ensembl.org",
                             c("Asia" = "asia.ensembl.org",
                               "West US" = "uswest.ensembl.org",
                               "East US" = "useast.ensembl.org"))

convert_input <- selectizeInput(
    "convert_to", "Convert to (might take a while to load, be patient!):" , choices = NULL,
    options = list(create = TRUE, plugins = list('remove_button')), multiple = T
)


# output table

table_output <- div(#style="height:600px; overflow:scroll; align:text-center",
    DT::dataTableOutput("converted_table")
)


# download_output <- downloadButton("downloadData", "Download")


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Convert gene ID"),
    h3("By Johannes Nicolaus Wibisana 2020/08/07"),
    h4("Accepts csv with header, first column will be read as input"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            file_input,
            organism_input,
            keytype_input,
            host_input,
            convert_input
            
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            table_output
        )
    )
))
