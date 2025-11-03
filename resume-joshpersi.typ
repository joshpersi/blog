#set page(
  margin: 0.5in,
  paper: "us-letter"
)

#set text(
  font: "Noto Serif",
  fill: rgb("#2E3440"),
  size: 10pt,
)

#set par(justify: false)

// Heading
#align(center)[
  #text(size: 25pt, weight: "bold")[Josh Persi]
  #v(-20pt)
  
  #text(size: 10pt)[
    (604) 809-8648 | 
    #link("mailto:joshpersi@gmail.com")[joshpersi\@gmail.com] | 
    #link("https://linkedin.com/in/josh-persi")[linkedin.com/in/josh-persi] |
    #link("https://github.com/joshpersi")[github.com/joshpersi]
  ]
]

// Section heading function
#let section(title) = {
  v(5pt)
  text(size: 12pt, weight: "bold")[#smallcaps(title)] 
  v(-10pt)
  line(length: 100%, stroke: (thickness: 0.5pt, paint: rgb("#2e3440")))
  v(-10pt)
}

// Resume subheading function
#let resume_heading(title, location, subtitle, date) = {
  v(5pt)
  grid(
    columns: (1fr, auto),
    gutter: 10pt,
    text(weight: "bold")[#title],
    text[#location],
  )
  v(-7.5pt)
  grid(
    columns: (1fr, auto),
    gutter: 10pt,
    text(style: "italic", size: 10pt)[#subtitle],
    text(style: "italic", size: 10pt)[#date],
  )
  v(-5pt)
}

// Project heading function
#let project_heading(title, date) = {
  v(5pt)
  grid(
    columns: (1fr, auto),
    gutter: 10pt,
    text(size: 10pt)[#title],
    text(size: 10pt)[#date],
  )
  v(-5pt)
}

// Projects
#section[Professional Summary]

#lorem(50)
#v(-5pt)

// Technical Skills
#section[Technical Skills]

#pad(left: 0pt)[
  #text(size: 10pt)[
    *Languages*: R, Python, SQL (PL-SQL, T-SQL), HTML/CSS, JavaScript, Rust \
    *Developer Tools*: Git, Docker, VS Code, Positron \
    *Libraries*: dplyr, purrr, ggplot2, targets, sf, terra, leaflet
  ]
]

// Education
#section[Education]

#resume_heading(
  [McGill University],
  [Montréal, QC],
  [Master of Science, Department of Biology],
  [Jan. 2018 -- Dec. 2020]
)

#resume_heading(
  [University of Guelph],
  [Guelph, ON],
  [Bachelor of Science in Environmental Sciences, Department of Integrative Biology],
  [Sep. 2013 -- Apr. 2017]
)

// Experience
#section[Experience]

#resume_heading(
  [Science Specialist],
  [Ottawa, ON],
  [Canadian Food Inspection Agency],
  [October 2021 -- Present]
)

#list(
  indent: 10pt,
  [#lorem(15)],
  [#lorem(15)],
  [#lorem(15)]
)

#resume_heading(
  [Assistant Field Botanist],
  [Toronto, ON],
  [Toronto Region Conservation Authority],
  [Apr. 2021 -- Oct. 2021]
)

#list(
  indent: 10pt,
  [#lorem(15)],
  [#lorem(15)],
  [#lorem(15)]
)

// Projects
#section[Projects]

#project_heading(
  [*Project name* | _project tech stack_],
  [June 2020 -- Present]
)

#list(
  indent: 10pt,
  [#lorem(15)],
  [#lorem(15)],
  [#lorem(15)],
  [#lorem(15)]
)

#project_heading(
  [*Project name* | _project tech stack_],
  [May 2018 -- May 2020]
)

#list(
  indent: 10pt,
  [#lorem(15)],
  [#lorem(15)],
  [#lorem(15)],
  [#lorem(15)]
)
