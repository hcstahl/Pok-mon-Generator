# PokemonGenerator
Application in Rshiny that generates a Pokemon based on user input and displays the Pokemon and visulizations.
https://haileystahl.shinyapps.io/PokemonGenerator/
# Table of Contents
[](#)<br />




[Start](#Start)<br />
[Side Bar Layout](#)<br />
[Main Panel](#)<br />
[Server](#)<br />
[Deployment Notes](#)<br />
[Helpful References](#)<br />
[](#)<br />

# Start
**Line 1-13**: Is included before the start of the ui. <br />
I included graphs that were not dependent on output from the application at the start to make it easier to understand.<br />

**Line 59**: This is the start of the ui code for the front end of the application.<br />
I used a theme for the rshiny application instead of the default theme and the title for the application<br />

# Side bar Layout
**Line 63:**: The side bar layout is a way to include the sidebar panel and main panel.<br />
I included the side bar panel first which is the grey bar going down the side of the application.<br />
Note this side bar is static and does not go in and out.<br />

**Line 65-101**: Includes the two buttons at the top of the panel. 
The buttons have an ID in " " which reference the output by the server at the end. <br />
After is the creation of each input inside of the side bar panel. (8 total inputs) <br />

# Main Panel

**Line 110**: Starts the creation of the main panel which is the area outside of the sidebar that was just created.<br />
It's important to make sure a ) ends the sidebarPanel but does not end the sidebarLayout section.<br />
The main panel has be included with the side bar layout.<br />

The  tabsetPanel() enables being able to switch tabs and change the display of the window.<br />
The  tabPanel() is each tab in the panel. <br />
Each tab panel should still be inside the tabsetPanel() and the content in each tab should be within the TabPanel() of the individual tab.<br />

**Line 112 -115**: This is the first tab in the tabsetPanel. 
It includes a title,a uiOutput from the server, tags$hr() which is a way to insert a line, data table Output from the server.
The tab ends with the enclosed )

**Line 116 -131**: This is the second tab in the tabsetPanel. 
This includes all of the plotOutput from the server and different tags$ for the text output on the tab.



**Line 132 -154**: This is the third tab in the tabsetPanel. 
The tags$br allows for the text to stay on the esame line.




**Line 155- 162**: This is the fourth tab in the tabsetPanel. 
 The tags$a lets you link a text to a url.

*It's important to keep proper track of the ) so the information within each tab stays in the tab you want.

**Line 165**: This includes parenthesis to end eveyrthing inside the <-ui function starting on line 59.



# Server
**Line 169**: Starts the function for the back end part of the application.

**Line 170 - 238**: Includes every action that will occur when the "actionbutton" is pressed. This is the "Complete" Button on the top of the page.





**Line 241- 292**: Includes every action that will occur when the "randombutton": is pressed.




**Line 299**: This } ends the content inside of the server. It's important to make sure this matches up or you will get an error before the ShinyApp line.


# Deployment Notes



# Helpful References
