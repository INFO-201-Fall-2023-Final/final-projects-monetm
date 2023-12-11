# LIBRARY ----
library(dplyr)
library(stringr)
library (shiny)
library(ggplot2)
library(tidyr)

# DATASHEET ----
df <- read.csv("final_project_df.csv")
#wa_df <- read.csv("wa_ws_df.csv")

#UI SECTION
ui <- fluidPage(
  navbarPage("INFO 201 - Group Project",
             
#Panel One UI [EDIT QUESTIONS AT END] ----             
    tabPanel("Project Overview",
                      
                      h1("Introduction:"),
                        p(""),
                      p("Amidst the picturesque landscapes of the U.S., a historical shift from pedestrian-friendly streets to car-centric development has inadvertently fueled rising chronic diseases. Walkability challenges, compounded by inconsistencies in accessibility, impact residents' well-being and local economies. Yet, areas prioritizing walkability see benefits ranging from reduced pollution to improved health and community well-being."),
                        p(""),
                      p("Our project utilizes a comprehensive dataset that combines health metrics (e.g., chronic disease prevalence) with urban design indicators (e.g., walkability scores) across U.S. states. Focused on understanding the link between city walkability and chronic diseases, the dataset offers insights into the health implications of urban design decisions. The goal is to inform strategies for improving community well-being through informed urban planning. By exploring the correlation between low walkability scores and increased chronic diseases, the project aims to guide urban design towards addressing pressing health and environmental issues, unveiling a narrative of inequitable health conditions influenced solely by one's place of residence, and challenging the prevailing notion that reliance on cars is without significant externalities"),
                        p(""),

             h1("Background & Context"),
             h2("Research Questions:"),

             p("1. What is the correlation between Physical Health factors such as Obesity against Mean State Walking Scores?"),
             p(""),
             p("2. How do Walking Score factors regarding commuting and intersection density affect respiratory diseases such as Asthma?"),
             p(""),
             p("3. Is there a link between Metabolic Syndrome and lower walking scores?"),

             h2("Datasets Used:"),
             h3("1. 2019 Walkability Index (EPA)"),
             p("The U.S. Environmental Protection Agency's National Walkability Index, featuring 220,741 observations and 117 features, is instrumental in dissecting urban walkability. It pinpoints key aspects such as street intersection density, proximity to transit stops, and diversity of land uses. This dataset facilitates a granular analysis, helping us understand the specific elements contributing to walkability in various regions."),
             p(""),
             p("Dataset Source:", a(href = "https://catalog.data.gov/dataset/walkability-index1", "Link"), "."),


             p(""),
             h2(""),
             h3("2. U.S. Chronic Disease Indicators (CDI)"),
             h5("Filtered for 2019 Data"),
             p("Curated by the CDC's Division of Population Health, the U.S. Chronic Disease Indicators (CDI) with 1,185,678 observations and 34 features provides a comprehensive view of chronic disease prevalence. This dataset acts as a crucial lens to examine the health landscape. By correlating walkability scores from Dataset One with chronic disease indicators, we gain insights into how urban design influences public health. Together, these datasets form a powerful analytical tool to inform targeted strategies for urban planning, addressing health disparities and fostering community well-being."),
             p("Dataset Source:", a(href = "https://catalog.data.gov/dataset/u-s-chronic-disease-indicators-cdi", "Link"), "."),


             h2("Intended Domain"),
             h4("Urban Planning - Public Health - Environmental Science"),
             h3("Purpose:"),
             p("This investigation focuses on exploring the correlation between walkability scores in urban and suburban areas and the prevalence of chronic diseases among residents. The dataset, combining chronic disease indicators and walking scores, aims to analyze trends and correlations, providing insights into how the built environment, specifically walkability, may influence residents' health and contribute to chronic disease prevalence. This comprehensive dataset can be utilized to identify patterns, make inferences about the relationship between urban design and health outcomes, and potentially guide urban planning efforts for the creation of healthier communities."),
             h3("Other Responsible Uses"),
             p("Equitable Access to Healthcare Services: The dataset can be employed to assess how walkability impacts residents' access to healthcare, uncovering potential disparities based on walkability scores."),
             h4("No Restrictions: The dataset is made available for use without any restrictions, encouraging responsible exploration and analysis within the specified domains."),
  ),

#Panel Two UI ---- 
   tabPanel("Analysis One",
      titlePanel(
      "Correlation between Walking Scores and Physical Health"),
    sidebarLayout(
      sidebarPanel(
         selectInput(
         inputId = "input2",
         label = "Select a Physical Health Problem:",
         choices = c("Obesity", 
                      "Self-Reported Health Status",
                      "Poor Physical Activity")
         )
      ),
         mainPanel(
           plotOutput("panelTwo")
           )
      ),
    h3("Summary"),
    p("From the Density Chart above we are able to decifer that there is a slight correlation between a lower walking score and physical ailments.
      Furthermore, we can take away from this data that those living in areas with lower or worse walking scores, reported having less leisure time for physical activity
      and having overall worse health. This can be correlated with higher obesity rates and potentially shorter life spans."),
    p("SOURCE: CDC - Behavioral Risk Factor Surveillance System (BRFSS)"),
    p("DATA VALUE TYPE: Age-Adjusted Prevalence")
   ),
#Panel Three UI ----
             tabPanel("Analysis Two",
                      titlePanel(
                        "Asthma Prevalence & Interurban Development"),
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons(
                            inputId = "input3",
                            label = "Select an Option:",
                            choices = list("Carpool Probability" = 1, 
                                           "Intersection Density" = 2)
                          ),
                        ),
                        mainPanel(
                          plotOutput("panelThree")
                        )
                      ),
                      h3("Summary"),
                      p("Another factor to consider when looking into walkability scores, is the corresponding environmental factors such as air pollution. 
                        Theoretically, cities with higher walkability scores would decrease the need for individual commuters and instead promote public transportation or carpooling.
                        These scatter plots attempt to analyze correlation between air pollution from traffic and the prevalance of asthma. As we can see, there is a weak correlation
                        betwwen factors such as the density of pedestrian intersections and the likelihood of carpooling. Therefore, we may be able to take away that the greater the
                        need commuters have for a car, the greater the likelihood local individuals have of developing asthma."),
                      h5("Data Insight"),
                      p("SOURCE: CDC - Behavioral Risk Factor Surveillance System (BRFSS)"),
                      p("DATA VALUE TYPE: Age-Adjusted Prevalence")
                      ),

#Panel Four UI ----
             tabPanel("Analysis Three",
                      titlePanel(
                        "Metabolic Syndrome v Walking Scores"),
                        sidebarLayout(
                          sidebarPanel(
                            radioButtons(
                              inputId = "input4a",
                              label = "Select an Option:",
                              choices = list("High Cholesterol Prevalence" = 1, 
                                             "Diabetes Prevalence" = 2)
                                        ),
                            sliderInput("input4b",
                                        "Walk Score:",
                                        min = 7,
                                        max = 11,
                                        value = 9,
                                        step = 1,
                                        animate =
                                          animationOptions(interval = 1000, loop = TRUE)),   
                          ),
                          mainPanel(plotOutput("panelFour"))
                        ),
                      h3("Summary"),
                      p("Lastly, there is a disease known as Metabolic Syndrome that increases the high cholesterol for individuals. Factors like this 
  can additionally increase the chance of heart disease, stroke, and diabetes. Therefore by studying the relationship between cholesterol, diabetes, and walking scores,
  we can discern their subsequent effects on public health. As we increase the walking score, we can see an incremental shift left, indicating lower population prevalences
  of higher cholesterol and diabetes. Therefore, we can discern that Metabolic syndrome becomes less likely in areas with greater walkability scores."),
                      h5("Data Insight"),
                      p("SOURCE: CDC - Behavioral Risk Factor Surveillance System (BRFSS)"),
                      p("DATA VALUE TYPE: Age-Adjusted Prevalence")
                      )

)
)
#Server Section

server <- function(input, output){
# Panel Server 1 ----
  
# Panel Server 2 ----
  
  plot_func_2 <- function(disease) {
  
    if (disease == "Obesity") {
      plot <- ggplot(df, 
               mapping = aes(x = avg_walk, y = Obesity))+
        stat_density_2d(aes(fill = ..density..), geom = "raster", contour = FALSE) +
        scale_fill_distiller(palette= "Reds", direction=1) +
        scale_x_continuous(expand = c(0, 0)) +
        scale_y_continuous(expand = c(0, 0)) +
        theme(legend.position='none')+
        labs(x = "National Walking Score Index Mean per State", 
             y = "Overweight or obesity among adults aged >= 18 years", 
             title = "Obesity v National Mean Walking Scores")
      
    } else if (disease == "Self-Reported Health Status") {
      plot <- ggplot(df, 
               mapping = aes(x = avg_walk, y = Status))+
        stat_density_2d(aes(fill = ..density..), geom = "raster", contour = FALSE) +
        scale_fill_distiller(palette="RdPu", direction=1) +
        scale_x_continuous(expand = c(0, 0)) +
        scale_y_continuous(expand = c(0, 0)) +
        theme(legend.position='none')+
      labs(x = "National Walking Score Index Mean per State", 
           y = "Fair or poor self-rated health status among adults aged >= 18 years", 
           title = "Self-Reported Health Status v National Mean Walking Scores")

  } else if (disease == "Poor Physical Activity") {
    plot <- ggplot(df, 
            mapping = aes(x = avg_walk, y = Activity))+
      stat_density_2d(aes(fill = ..density..), geom = "raster", contour = FALSE) +
      scale_fill_distiller(palette=4, direction=1) +
      scale_x_continuous(expand = c(0, 0)) +
      scale_y_continuous(expand = c(0, 0)) +
      theme(legend.position='none')+
      labs(x = "National Walking Score Index Mean per State", 
           y = "No leisure-time physical activity among adults aged >= 18 years", 
           title = "Physical Activity v National Mean Walking Scores")
  }
    return(plot)
}
  
  output$panelTwo <- renderPlot({
    plot_func_2(input$input2)
    })

  
# Panel Server 3 ----

plot_func_3 <- function(name){
  if (name == 1){
    plot <- ggplot(df, aes(x = Asthma, y = avg_commute)) + 
      geom_point()+
      geom_smooth()+
      xlim(10, 12)+
      labs(x = "Current asthma prevalence among adults aged >= 18 years", 
           y = "Predicted commute mode split", 
           title = "Commuting Trends v Asthma Prevalence")
      
  } else if (name == 2) {
    plot <- ggplot(df, aes(x = Asthma, y = avg_intersection)) + 
      geom_point()+
      geom_smooth()+
      xlim(10, 12)+
      labs(x = "Current asthma prevalence among adults aged >= 18 years", 
           y = "Street intersection density", 
           title = "Intersection Trends v Asthma Prevalence")
  }
  return(plot)
}
  
  output$panelThree <- renderPlot({
    plot_func_3(input$input3)
  })
  
  
  
# Panel Server 4 ----
  plot_func_4 <- function(dis){
    df_4 <- filter(df, avg_walk_rd == input$input4b)
    
    if (dis == 1){ 
      plot <- ggplot(df_4, aes(x = Cholesterol)) + 
          geom_histogram( binwidth=2, fill="purple", color="#e9ecef", alpha=0.9)+
          xlim(25, 35)+
          ylim(0, 5)+
          labs(x = "High cholesterol prevalence among adults aged >= 18 years", 
             y = "Occurences", 
             title = "High Cholesterol v Walking Scores")
        

    } else if (dis == 2) {
      plot <- ggplot(df_4, aes(x = Diabetes)) + 
        geom_histogram( binwidth=2, fill="maroon", color="#e9ecef", alpha=0.9)+
        xlim(7, 17)+
        ylim(0, 3)+
        labs(x = "Prevalence of diagnosed diabetes among adults aged >= 18 years", 
             y = "Occurences", 
             title = "Diabetes v Walking Scores")
    }
    return(plot)
  }
  
 
  output$panelFour <- renderPlot({
    plot_func_4(input$input4a)
  })
}

shinyApp(ui, server)