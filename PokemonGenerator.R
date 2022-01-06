library(tidyverse)
library(shinydashboard)
library(shinyWidgets)
library(dplyr)
library(waffle)
library(shiny)
library(gridExtra) 
library(ggplot2)
library(bslib)
library(readxl)
library(DT)

data <- read_csv("Pokemoncsv.csv")

data$`Type 2`<- replace_na(data$`Type 2`, "No")
data$Legendary<- ifelse(data$Legendary =="FALSE","No","Yes")

Barchartcount<-ggplot(data = data, aes(y = `Type 1`,fill = `Type 1`)) +
  geom_bar() + theme(legend.position = "none",axis.title =element_text(colour ="#5a5a5a", size = 16)
                     ,axis.text = element_text(size = 12,color = "#5a5a5a")
                     ,axis.title.x = element_blank()
                     ,axis.ticks.y = element_line(colour = "white")
                     ,axis.ticks.x = element_line(colour = "white")
                     ,panel.background = element_rect(fill = "white"
                     )) 


Barchartcount2<-ggplot(data = data, aes(y = `Type 2`,fill = `Type 2`)) +
  geom_bar() + theme(legend.position = "none",axis.title =element_text(colour ="#5a5a5a",size = 16)
                     ,axis.text = element_text(size = 12,color = "#5a5a5a")
                     ,axis.title.x = element_blank()
                     ,axis.ticks.y = element_line(colour = "white")
                     ,axis.ticks.x = element_line(colour = "white")
                     ,panel.background = element_rect(fill = "white"
                     )) 

gen<-c('1' = 20,
       '2' = 13,
       '3' = 20,
       '4' = 15,
       '5' = 20,
       '6' = 10)

leg<-c("Legendary" =8,
       "Non-Legendary" =92 )



wgen<-waffle(gen, rows =5,size=1,colors = c("#D291BC","#FFDFD3","#76BACB",
                                                 "#FFAFA3","#CAEAD0","#D1D1D1")) 

wwlegend<-waffle(leg, rows =5,size=1,colors = c("#494746","#FAF5EF"),legend_pos = "none")






ui <- fluidPage(
    theme = bs_theme(version = 5, bootswatch = "minty"),
    titlePanel("What Pokemon will choose you?"),
    
    sidebarLayout(
        sidebarPanel(
            tags$text("Everytime you hit a button your Pokemon will change!"),
            actionButton("actionbutton", label = "Complete",width =130),
            actionButton("randombutton", label = "Random",width =100),
            tags$hr(),
            selectInput('firsttype', "Select your first type", choices = c("Water","Fire","Grass","Electric","Ice","Rock","Poison","Bug","Normal","Fighting","Flying","Psychic","Dragon","Ground","Steel","Ghost","Dark","Fairy"), selected = "Water"),
            selectInput('secondtype', "Second Type", choices = c("Random"), selected = "Random"),
            sliderInput('health', "Select your health", min = 20, 
                        max = 100, value = 50),
            sliderInput("speed", label = h3("Select your Speed"), min = 20, 
                        max = 100, value = 50),
            sliderInput("nspeed", label = h3("Select your normal Attack Speed"), min = 20, 
                        max = 100, value = 50),
            
            sliderInput("ndamage", label = h3("Select your normal Damage resistance"), min = 20, max = 100, value = 50), 
            tags$h1("Select your SPECIAL"),
            knobInput(
                inputId = "circle1",
                label = " Attack speed",
                value = 20,
                min = 20,
                max = 180,
                displayPrevious = TRUE, 
                lineCap = "round",
                fgColor = "#3eb489",
                inputColor = "#d3d3d3"
            ),
            knobInput(
                inputId = "circle2",
                label = "Damage Resistance",
                value = 20,
                min = 20,
                max = 200,
                displayPrevious = TRUE, 
                lineCap = "round",
                fgColor = "#3eb489",
                inputColor = "#d3d3d3"
            ),
            
            tags$hr()),
        
        
        
        
        
        
        mainPanel(
            tabsetPanel(
                tabPanel("Your Pokemon",tags$h1('Your Pokemon is....',textOutput("p"))
                         ,uiOutput("link")
                         ,tags$hr()
                         ,DT::dataTableOutput("mytable"))
                         ,tabPanel("Visual",tags$text("Receive your Pokemon to see the graphs!")
                          ,tags$h1('Your Pokemon is....',textOutput("p2"))
                          ,tags$hr()
                          ,tags$text("The dotted line is your current Pokemon")
                          ,tags$h3("Frequency of Total Score For All Pokemon")
                          ,plotOutput("distPlot")
                          ,tags$h3("The Percent of Pokemon In Each Generation")
                          ,tags$text("Each box represents 1%","1 = Generation 1")
                          ,plotOutput("distplot3")
                          ,tags$h3("The Percent Of Legendary Pokemon")
                          ,tags$text("Only 8% of Pokemon are Legendary!")
                          ,plotOutput("distplot4")
                          ,tags$h3("The Total Number Of Pokemon For Each Type")
                          ,tags$text("Type 1 on the left")
                          ,plotOutput("distPlo2t")
                          ,tags$hr())
                ,tabPanel("Help",tags$h1("Guide")
                          ,tags$hr()
                          ,tags$br("ID: Is the ID from the pokedex associated with each Pokemon")
                          ,tags$br("Type1: Is the main type of your Pokemon")
                          ,tags$br("Type2: Is if the pokemon has a second type.")
                          ,tags$br("HP: Is how healthy your Pokemon is.")
                          ,tags$br("Attack: Is the speed for normal attacks.")
                          ,tags$br("Defense:Is the damage resistance for normal attacks.")
                          ,tags$br("Sp.Atk: Is the speed for special attacks.")
                          ,tags$br("Sp.Def: Is the damage resistance for special attacks.")
                          ,tags$br("Speed: Is how quick your Pokemon moves.")
                          ,tags$br("Generation: Is what generation your Pokemon is apart of.")
                          ,tags$br("Legendary: Is if your Pokemon is a true legend!")
                          ,tags$hr()
                          ,tags$h1('How the Calculator Works')
                          ,tags$hr()
                          ,tags$br("Just because you want the best Pokemon doesn't mean the Pokemon will choose you!")
                          ,tags$br("The Pokemon total is calculated by adding each numeric field for a total value.")
                          ,tags$br("Then your total is converted to a range. Your range is then checked against the Total score for each Pokemon of the same type you choose.")
                          ,tags$br("If your Pokemon type does not have a total score within your range then you will receive a Pokemon with a random total of the same Pokemon Type.")
                          ,tags$br("Your Pokemon type is the first priority!")
                          ,tags$br("The random button will generate a random Pokemon and disregard any input.")
                          ,tags$hr())
                          ,tabPanel("Source",tags$h1('Data Set Source')
                          ,tags$hr()
                          ,tags$a("Data Set",href="https://www.kaggle.com/abcsds/pokemon")
                          ,tags$hr()
                          ,tags$h1('Image Source')
                          ,tags$hr()
                          ,tags$a("Image Source",href="https://www.pokemon.com/")
                          ,tags$hr())


))))
            


server <- function(input, output, session) {
    observeEvent(input$actionbutton,{
        type1u<-as.character(input$firsttype)
        healthu<-as.numeric(input$health)
        speedu<-as.numeric(input$speed)
        nspeedu<-as.numeric(input$nspeed)
        ndamageu<-as.numeric(input$ndamage)
        spspeedu<-as.numeric(input$circle1)
        spdamageu<-as.numeric(input$circle2)
        
        usertotal<-healthu +speedu + nspeedu + ndamageu + spspeedu + spdamageu
        high<- usertotal+90 
        low<- usertotal-40
        #newtotal<-round(runif(1,min =low,max =high),0)
        checkbetween<- between(data$Total,low,high)
        
        sub1<-subset(data,`Type 1` == type1u & checkbetween == TRUE |`Type 1` == type1u & checkbetween == FALSE )
        pokemon<-sample(sub1$Name,1)
        output$p<-renderText(pokemon)
        output$p2<-renderText(pokemon)
        output$max <- renderPrint(high)
        output$min<-renderPrint(low)
        sub3<-subset(data,Name == pokemon)
        linkimage<-sub3$imageurl
        output$link<-renderUI(tags$a(href= linkimage,target="_blank","Click here to see your Pokemon"))
       
        
        output$mytable<-DT::renderDataTable(sub3[,1:13],options = list(
          searching = FALSE,
          pageLength = 1,
          lengthMenu = c(1)))
        
        
        output$distPlot <- renderPlot({
            x  <- data$Total
            bins <- 25
            vlinename<-sub3
            vline<-vlinename$Total
            # draw the histogram with the specified number of bins
            hist(x, breaks = bins, col = '#3EB489', border = 'white',xlab="Total Score",main = "")
            abline(v=vline,col="black",lty=3)
        })
        
        output$distPlo2t <- renderPlot({
          graphcombined<-grid.arrange(Barchartcount, Barchartcount2, ncol = 2)
        
        
        
        
        })
        
        output$distplot3 <- renderPlot({
          graph1<-plot(wgen)
          
          
          
          
        })
        
        output$distplot4 <- renderPlot({
          graph2<-plot(wwlegend)
          
          
          
        })
        
        
        
        
    })
      
        
    #Random button
    observeEvent(input$randombutton,{
        pokemon<-sample(data$Name,1)
        output$p<-renderText(pokemon)
        output$p2<-renderText(pokemon)
        sub3<-subset(data,Name == pokemon)
        linkimage<-sub3$imageurl
        output$link<-renderUI(tags$a(href= linkimage,target="_blank","Click here to see your Pokemon"))
       
        output$mytable<-DT::renderDataTable(sub3[,1:13],options = list(
            searching = FALSE,
            pageLength = 1,
            lengthMenu = c(1)))
        
        
        output$distPlot <- renderPlot({
            x  <- data$Total
            bins <- 25
            vlinename<-sub3
            vline<-vlinename$Total
            # draw the histogram with the specified number of bins
            hist(x, breaks = bins, col = '#3EB489', border = 'white',xlab="Total Score",main = "")
            abline(v=vline,col="black",lty=3)
        })
        
        
        output$distPlo2t <- renderPlot({
        graphcombined<-grid.arrange(Barchartcount, Barchartcount2, ncol = 2) 
          
          
          
          
        })
        
        output$distplot3 <- renderPlot({
          graph1<-plot(wgen)
          
          
          
          
        })
        
        
        
        output$distplot4 <- renderPlot({
          graph2<-plot(wwlegend)
          
          
          
        })
        
})

    

    

    
}
shinyApp(ui, server)











