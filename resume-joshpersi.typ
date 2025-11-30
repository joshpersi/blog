#set page(
  margin: 0.4in,
  paper: "us-letter",
)

#set text(
  font: "Noto Serif",
  fill: rgb("#2E3440"),
  size: 11pt,
)

#set par(leading: 0.5em, spacing: 0em)

#show link: underline

#align(center)[
  #text(size: 25pt, font: "Noto Serif", weight: "bold")[Josh Persi]

  #v(1em)

  #text(size: 10pt)[
    (604) 809-8648 |
    joshpersi\@gmail.com |
    #link("https://linkedin.com/in/josh-persi")[LinkedIn] |
    #link("https://bsky.app/profile/joshpersi.bsky.social")[Bluesky] |
    #link("https://github.com/joshpersi")[GitHub] |
    #link("https://joshpersi.github.io/blog")[Blog]
  ]

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
    strong[#title], text[#location],
  )
  v(0.5em)
  grid(
    columns: (1fr, auto),
    gutter: 10pt,
    text(style: "italic", size: 10pt)[#subtitle], text(style: "italic", size: 10pt)[#date],
  )
  v(0.5em)
}

// Project heading function
#let project_heading(title, date) = {
  grid(
    columns: (1fr, auto),
    gutter: 10pt,
    text(size: 10pt)[*#title*], text(style: "italic", size: 10pt)[#date],
  )
}

// List wrapper function with consistent spacing
#let section_list(..items) = {
  list(
    indent: 10pt,
    ..items,
  )
}

#section[Professional Summary]

#v(0.5em)

I am a data scientist with five years of professional experience. Over this time, I developed end-to-end productionized pipelines for data analysis. I used my strong technical skills in coding with R, Python, and SQL to create high-value products for diverse stakeholders and senior management. My work has entailed modelling, statistics, and experimental design, and been fast, robust, and reproducible from my use of unit testing and version control.

#v(1em)

#section[Technical Skills]

#v(0.5em)

*Languages:* R, Python, SQL (PL-SQL, T-SQL), Markdown, YAML, Typst, Bash \
*Developer Tools:* Git, Azure Devops, GitHub, Quarto, VS Code / Positron, Docker, WSL \
*Libraries:* polars, duckdb, pyarrow, pytask, pytest, uv, pandas, numpy

#v(1em)

#section[Experience]

#v(0.5em)

#resume_heading(
  [Science Specialist],
  [Ottawa, ON],
  [Canadian Food Inspection Agency],
  [Oct. 2021 -- Present],
)

#section_list(
  [Developed productionized ETL and analytical pipelines in R and Python to download and augment data],
  [Contributed to the design of complex survey programs via sample size calculations],
  [Applied time series models (ARIMA) to forecast the number of business activities.],
  [Applied NLP (stemming, tokenization, part-of-speech) and LLMs to extract structure from free text data],
  [Used Git to maintain version-controlled project histories; using rebases, pull-requests, and merges],
  [Used unit testing, parallel tests, test fixtures, and snapshot tests, to deliver high-quality code],
  [Transformed data via scaling, decomposition, encoding, missing value imputation, _.etc_ via pipelines],
  [Built and maintained multi-functional relationships with policy makers, scientists, and data engineers],
  [Quantified the risk of adverse effects (biological pest outbreaks) to manage and prioritize risk],
  [Built minimal viable products as fast as possible for immediate input and iterative development],
  [Dove deep into policy strategies and business context to understand the data-science needs of the business],
)

#v(1em)

#resume_heading(
  [Assistant Field Botanist],
  [Toronto, ON],
  [Toronto Region Conservation Authority],
  [Apr. 2021 -- Oct. 2021],
)

#section_list(
  [Conducted botanical surveys throughout Toronto to document rare and invasive plant species],
)

#v(1em)

#section[Education]

#v(0.5em)

#resume_heading(
  [McGill University],
  [Montréal, QC],
  [Master of Science, Department of Biology],
  [Jan. 2018 -- Dec. 2020],
)

#section_list(
  [Applied complex experimental design with consideration of controls, treatments, sample sizes, _.etc_],
  [Used generalized linear models in R to identify important predictors],
  [Used generalized linear mixed models to account for random effects due to spatiotemporal clustering],
  [Used stepwise model selection based on information criteria (_e.g._ AIC, BIC) to identify the optimal model],
)

#v(1em)

#resume_heading(
  [University of Guelph],
  [Guelph, ON],
  [Bachelor of Science in Environmental Sciences, Department of Integrative Biology],
  [Sep. 2013 -- Apr. 2017],
)

#section_list(
  [Designed a fully factorial experiment involving two predictors and several response variables],
  [Applied inferential tests (two-way ANCOVA) to identify the predictors with an impact on the response],
)

#v(1em)

#section[Projects]

#v(0.5em)

#project_heading([TidyTuesday], [Aug. 2025 -- Present])

#v(0.5em)

#section_list(
  [Participated in weekly exercises to visualize a new dataset in a novel or insightful way],
)

#v(1em)

#project_heading([Data Sciene Learning Community], [Feb. 2024 -- Present])

#v(0.5em)

#section_list(
  [Participated in weekly bookclubs on topics such as data visualiation, devops, and maching learning],
)

#v(1em)
