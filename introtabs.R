# Load the necessary libraries
library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Visualizing Walkability Score v Chronic Disease in the US"),

  # Create a tabset panel
  tabsetPanel(
    tabPanel("Introduction",


             p(""),

             p("Amidst the picturesque landscapes of the U.S., a historical shift from pedestrian-friendly streets to car-centric development has inadvertently fueled rising chronic diseases. Walkability challenges, compounded by inconsistencies in accessibility, impact residents' well-being and local economies. Yet, areas prioritizing walkability see benefits ranging from reduced pollution to improved health and community well-being."),
             p(""),
             p("Our project utilizes a comprehensive dataset that combines health metrics (e.g., chronic disease prevalence) with urban design indicators (e.g., walkability scores) across U.S. states. Focused on understanding the link between city walkability and chronic diseases, the dataset offers insights into the health implications of urban design decisions. The goal is to inform strategies for improving community well-being through informed urban planning. By exploring the correlation between low walkability scores and increased chronic diseases, the project aims to guide urban design towards addressing pressing health and environmental issues, unveiling a narrative of inequitable health conditions influenced solely by one's place of residence, and challenging the prevailing notion that reliance on cars is without significant externalities"),
             p(""),
             img(src = "/Users/anikamohan/Downloads/INFO 201/final project stuff/image1.jpeg", height = 300, width = 300),
             #images1-3 side by side
             # fluidRow(
             #   column(4, img(src = "/Users/anikamohan/Downloads/INFO 201/final project stuff/image1.jpeg", height = 300, width = 300),
             #   column(4, img(src = "/Users/anikamohan/Downloads/INFO 201/final project stuff/image2.jpeg", height = 300, width = 300)),
             #   column(4, img(src = "/Users/anikamohan/Downloads/INFO 201/final project stuff/image3.PNG", height = 300, width = 300)),

    ),
    # Add more tabs as needed
    tabPanel("Background/Context",
             h2("Research Questions:"),

             p("1. Are cities with a higher mortality rate for cardiovascular disease from 2015-2020, more likely to have worse walkability scores? "),
             p(""),
             p("2. Are states that are less likely to carpool correlated with a higher percentage of those battling asthma?"),
             p(""),
             p("3. Does a higher mix of office space and occupied housing linked to better mental health?"),

             h2("Datasets Used:"),
             h3("1. Walkability Index (EPA)"),
             p("The U.S. Environmental Protection Agency's National Walkability Index, featuring 220,741 observations and 117 features, is instrumental in dissecting urban walkability. It pinpoints key aspects such as street intersection density, proximity to transit stops, and diversity of land uses. This dataset facilitates a granular analysis, helping us understand the specific elements contributing to walkability in various regions."),
             p(""),
             p("dataset sourced from", a(href = "https://catalog.data.gov/dataset/walkability-index1", "here"), "."),

             p(""),
             h2(""),
             h3("2. U.S. Chronic Disease Indicators (CDI)"),
             p("Curated by the CDC's Division of Population Health, the U.S. Chronic Disease Indicators (CDI) with 1,185,678 observations and 34 features provides a comprehensive view of chronic disease prevalence. This dataset acts as a crucial lens to examine the health landscape. By correlating walkability scores from Dataset One with chronic disease indicators, we gain insights into how urban design influences public health. Together, these datasets form a powerful analytical tool to inform targeted strategies for urban planning, addressing health disparities and fostering community well-being."),

             h2("Intended Domain"),
             h4("Urban Planning - Public Health - Environmental Science"),

             h3("Purpose:"),
             p("This investigation focuses on exploring the correlation between walkability scores in urban and suburban areas and the prevalence of chronic diseases among residents. The dataset, combining chronic disease indicators and walking scores, aims to analyze trends and correlations, providing insights into how the built environment, specifically walkability, may influence residents' health and contribute to chronic disease prevalence. This comprehensive dataset can be utilized to identify patterns, make inferences about the relationship between urban design and health outcomes, and potentially guide urban planning efforts for the creation of healthier communities."),

             h3("Other Responsible Uses"),
             p("Equitable Access to Healthcare Services: The dataset can be employed to assess how walkability impacts residents' access to healthcare, uncovering potential disparities based on walkability scores."),

             h4("No Restrictions: The dataset is made available for use without any restrictions, encouraging responsible exploration and analysis within the specified domains."),
    )
  )
)

server <- function(input, output) {
  # Your server code here
}

# Run the application
shinyApp(ui = ui, server = server)

