#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(biomaRt)
library(DT)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    
    observe({
        
        organism <- input$organism
        
        all_attributes <- listAttributes(useMart("ensembl", dataset = paste0(organism,"_gene_ensembl"), host = input$host))
        
        updateSelectizeInput(session,
                             "convert_to",
                             label = "Convert to:",
                             choices = all_attributes$name)
    }) 
    
    
    
    
    
    

# output table ------------------------------------------------------------
    
    output$converted_table <- DT::renderDataTable({
        
        inFile <- input$file1
        
        if (is.null(inFile))
            return(NULL)
        
        # read input file
        input_genes <- read_csv(inFile$datapath) %>% pull(1)
        
        organism <- input$organism
        
        converted_genes <- getBM(attributes= c(input$keytype, input$convert_to),
                                 filters = input$keytype,
                                 values = input_genes,
                                 mart = useMart("ensembl", dataset = paste0(organism,"_gene_ensembl"), host = input$host)
                                 # uniqueRows = unique_rows
        )
        
        print(converted_genes)
        
    },
    server=FALSE,
    extensions = c('Buttons', 'Scroller'), 
    options = list(
        dom = 'Bfrtip',
        scrollY = 400,
        scroller = TRUE,
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
    ),
   # align = "c",
   # width = "100%"
    )

})
