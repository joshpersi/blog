#set page(
  margin: 0.5in,
  paper: "us-letter",
)

#set text(
  font: "Noto Serif",
  fill: rgb("#2E3440"),
  size: 11pt,
)

#set par(leading: 0.6em,spacing: 0em)

#show link: underline

#align(center)[
  #text(size: 25pt, font: "Noto Serif", weight: "bold")[Josh Persi]
  
  #v(1em)

  Vancouver, BC | 
  (604) 809-8648 |
  joshpersi\@gmail.com |
  #link("https://linkedin.com/in/josh-persi")[LinkedIn] 
  #v(1em)
]


#let section(title) = {
  text(size: 12pt, font: "Noto Serif", weight: "bold")[#smallcaps(title)]
  v(0.25em)
  line(length: 100%, stroke: (thickness: 0.5pt, paint: rgb("#2e3440")))
}

#let resume_heading(title, location, subtitle, date) = {
  grid(
    columns: (1fr, auto),
    gutter: 10pt,
    strong[#title],
    text[#location],
  )
  v(0.5em)
  grid(
    columns: (1fr, auto),
    gutter: 10pt,
    text(style: "italic", size: 10pt)[#subtitle],
    text(style: "italic", size: 10pt)[#date],
  )
  v(0.5em)
}

// Project heading function
#let project_heading(title, date) = {
  grid(
    columns: (1fr, auto),
    gutter: 10pt,
    text(size: 10pt)[*#title*],
    text(style: "italic", size: 10pt)[#date],
  )
}

// List wrapper function with consistent spacing
#let section_list(..items) = {
  list(
    indent: 10pt,
    ..items
  )
}

#section[Professional Summary]

#v(0.5em)

Data analyst with five years of experience and strong skills in the development of end-to-end ETL pipelines using enterprise task orchestrators. An academic background in biological sciences with the ability to think critically about complex interdependent systems. Significant experience using R for end-to-end analytical pipelines with a strong grasp of relational models, schema design,software engineering, and Azure. Adept at forming strong professional relationships with multidisciplinary teams to drive business goals.

#v(1em)

#section[Experience]

#v(0.5em)

#resume_heading(
  [Science Specialist],
  [Ottawa, ON],
  [Canadian Food Inspection Agency],
  [Oct. 2021 -- Present]
)

#section_list(
  [Combed through existing ETL pipelines to identify and refactor inappropriate joins  – resulting in 500k additional records being available],
  [Developed a novel processing pipeline to extract geographic coordinates for millions of text addresses – solving a years-long business problem by making these addresses usable for risk analytics],
  [Deployed Python scripts within an Azure environment for scheduled remote execution - ensuring laboratory data was always up to date],
  [Modernized the data science development life-cycle by implementing software engineering best practices, including version control with Git, automated testing, and reproducible virtual environments],
  [Spearheaded the adoption of Microsoft Fabric, leveraging a Lakehouse architecture similar to Databricks to unify disparate data streams into a single source of truth],
  [Leveraged compute and storage services from the Azure Cloud to analyze large global datasets],
  [Introduced both Dagster and Apache Airflow as solutions to orchestrate Agency ETL pipelines],
  [Implemented the first predictive capacity model for CFIA laboratories via an ARIMA time-series model to forecast annual work capacity],
  [Engineered an automated reporting pipeline by integrating SQL for retrieval of complex data and R for programmatic analysis, replacing a labor-intensive 3-day manual process],
  [Modelled lab technician performance using binomial logistic regression to analyze success rates, ensuring regulatory alignment with international seed testing compliance standards],
  [Determined statistically valid sample sizes for potato-wart resistance studies by performing power analyses to reach a target confidence level of 95%],
  [Introduced interactive, regularly updating Power BI reports as a solution to ad-hoc, manually generated data extracts – increasing data availability and saving at least 5 hours per week],
  [Collaborated with national stakeholders to identify gaps in a Canada-wide data-sharing system, translating complex requirements into custom-built analytical tools – formally recognized for Scientific Innovation for two consecutive years for significantly improving the system’s utility and user engagement],
  [Successfully secured multi-year financial support and executive buy-in for ongoing analytics projects by demonstrating the direct impact of novel techniques on agency goals]
)

#v(1em)

#section[Education]

#v(0.5em)

#resume_heading(
  [McGill University],
  [Montréal, QC],
  [Master of Science, Department of Biology],
  [Jan. 2018 -- Dec. 2020]
)

#v(1em)

#resume_heading(
  [University of Guelph],
  [Guelph, ON],
  [Bachelor of Science in Environmental Sciences, Department of Integrative Biology],
  [Sep. 2013 -- Apr. 2017]
)


#v(1em)
