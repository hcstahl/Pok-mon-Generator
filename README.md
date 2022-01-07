# PokemonGenerator
Application in Rshiny that generates a Pokemon based on user input and displays the Pokemon and visulizations.
https://haileystahl.shinyapps.io/PokemonGenerator/
# Table of Contents
[Start](#Start)<br />
[Side Bar Layout](#Side-bar-Layout)<br />
[Main Panel](#Main-Panel)<br />
[Server](#Server)<br />
[Deployment Notes](#Deployment-Notes)<br />
[Helpful References](#Helpful-References)<br />


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

**Line 112 -115**: This is the first tab in the tabsetPanel. <br />
It includes a title,a uiOutput from the server, tags$hr() which is a way to insert a line, data table Output from the server.<br />
The tab ends with the enclosed )<br />

**Line 116 -131**: This is the second tab in the tabsetPanel. <br />
This includes all of the plotOutput from the server and different tags$ for the text output on the tab.<br />



**Line 132 -154**: This is the third tab in the tabsetPanel. <br />
The tags$br allows for the text to stay on the esame line.<br />




**Line 155- 162**: This is the fourth tab in the tabsetPanel. <br />
 The tags$a lets you link a text to a url.<br />

*It's important to keep proper track of the ) so the information within each tab stays in the tab you want.<br />

**Line 165**: This includes parenthesis to end eveyrthing inside the <-ui function starting on line 59.<br />



# Server
**Line 169**: Starts the function for the back end part of the application.<br />

**Line 170 - 238**: Includes every action that will occur when the "actionbutton" is pressed. This is the "Complete" Button on the top of the page.<br />
**Line 170**: Connects every action to the button with the ({ to the $actionbutton.<br />
**Line 171 - 177**: Converts the inputs from the user to the correct type.This will let us compare and perform calculations with the user input to our actual data set.<br />
**Line 179 -191**: Is details on how the generator was created, and how the table was able to match the output of the generator.<br />
1. The Total score was calculated by adding each user input<br />
2. A range was created based on this total.<br />
3. The Total score in the data set is checked to see if it falls inside the range.The check function returns a Boolean.<br />
4. The data is subsetted based on the user type matching the Type1 of the data set.<br />
5. Then the data is subsetted based on if the check function returns TRUE meaning the Total from the data set falls within the users total range.<br />
6. OR the data is subsetted based on if the check function returns FALSE meaning the Total from the data set does not fall within the users total range.<br />

Based on Order of operations, the first statement line 5 will be first and if this fails then the second or statement will execute.<br />
This was done so the generator would generate a Pokemon even if the user total score does not match a Pokemon of the same type with a similar Total range.<br />

**Line 192-193**: This is how the dynamically changing link was made. <br />
*The original data set does not include image url link, but the image source includes every picture for each Pokemon based on their Pokemon index number in order.<br />
I created a script in Python to generate the format of the end of the link and put this in a column in the data set.*<br />

The first line takes the same subsetted dataset which matches a single Pokemon.<br />
The $ accesses the imageurl column and since this only includes one Pokemon it will have the associated imageurl for the Pokemon.<br />

The second line converts this to an output.<br />
RenderUI has to be used because the text after includes HTML tags and this is not allowed for normal render text.<br />
tags$a() allows this to be a hyper link<br />
href is equal to the variable we put the associated $imageurl in.<br />
,target= allows the link to pop up in another tab and the text after is what the user will see.<br />

I included these two lines of code inside each button so it would display no matter what button is pressed to generate the Pokemon.<br />
You will the code inside this button is copied into the "Random Button" So the same results will show.<br />

**Line 196-199**: Generates the table output.
The subsetted data that matches to one Pokemon is used again and is subsetted again to only include the column numbers labled.<br />
   searching = FALSE, turns off the search component the table originally comes with.<br />
   pageLength = 1, Limits table to only output one page.<br />
   lengthMenu = c(1) makes the entries able to display nothing.<br />

**Line 202-210**: Is the reactive Histogram that has a line that moves based on the Pokemon chosen.<br />
I created the moving line by making the v = a variable that holds the Pokemon Total based on the subsetted data that includes only that Pokemon.<br />

**Line 212-233**: The code for these chart is originally in the first few lines of this code. <br />
 You can output charts that are not create inside the ui function or server function!<br />
 The grid.arrange function to combine the two charts together side by side.<br />


**Line 238**: This } Ends the contents inside of the Action Button.<br />

**Line 241- 292**: Includes every action that will occur when the "randombutton": is pressed.<br />
*The same code for the Action Button is inside the randombutton to generate the same output for each button.*<br />


**Line 299**: This } ends the content inside of the server. It's important to make sure this matches up or you will get an error before the ShinyApp line.<br />


# Deployment Notes
Below is notes that allowed my application to be deployed successfully <br />
1. Make sure thee is no install.packages <br />
2. Should be no errors in the application! This means errors that pop up or warnings even when your application continues to run locally.<br />
3. Make sure you are using the correct dataset when you deploy your application.<br />
4. Your data set should not include empty columns. <br />
EX: If importing from excel>CSV then uploading R should not show blank columns from excel that are not being used.<br />
6. Check to make sure the col names that output in the terminal are correct and include every column in your dataset.<br />
7. Data set and  application file should be in the same directory.<br />
8. Your data should be in the same directory so the import statement should be ("filename".csv") not ("/.../...filename.csv).<br />
9. DO not have a setwd(~) in the code.<br />
10. Switch to the Mark up tab in R to see any messages about Deployment issues.<br />

**Even the smallest errors that don't disrupt your local application can interupt Deployment.**

# Helpful References
[Guide to HTML Tags](https://shiny.rstudio.com/articles/tag-glossary.html)<br />
[Guide to Debugging Rshiny Errors](https://shiny.rstudio.com/articles/debugging.html)<br />
[R Shiny Data Table Customization](https://rstudio.github.io/DT/shiny.html)<br />

