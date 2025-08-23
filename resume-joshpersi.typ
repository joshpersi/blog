#set page(margin: 1cm)

#set text(font: "Noto Serif")

#text(size: 32pt, tracking: 0.05cm)[Josh Persi]  

#v(-20pt)

#text(size: 16pt)[Data Scientist]

#table(
  columns: 6,
  stroke: none,
  column-gutter: 1em,
  inset: (x: 0pt),
  [*Phone*], [(604) 809-8648],
  [*GitHub*], [#link("github.com/joshpersi")],
  [*Email*], [#link("joshpersi@protonmail.com")],
  [*LinkedIn*], [#link("linkedin.com/in/josh-persi")],
  [*Blog*], [#link("joshpersi.github.io/blog")],
  [*Bluesky*], [#link("@joshpersi.bsky.social")],
)

Data scientist with a passion 
I am a self-taught data scientist with a formal background in the biological sciences. My current work with the Canadian Food Inspection Agency involves leveraging government, industry, and open-source data to model pest risks to plant health in Canada.  

= Experience

#grid(
  columns: (1fr, 6fr),
  [2022 -- Present],
  [
  #smallcaps([Science Specialist])
  #v(-5pt)
  #text(style: "oblique")[Canadian Food Inspection Agency]

  - Provide analytics support to scientists and policy makers
  
  - Perform descriptive, predictive, diagnostic, and prescriptive analyses 

  - Create reproducible reports, dashboards, and Shiny applications 
  ]
)

#grid(
  columns: (1fr, 6fr),
  [2021 -- 2021],
  [
  #smallcaps([Field Botanist])
  #v(-5pt)
  #text(style: "oblique")[Toronto Region Conservation Authority]

  - Conduct biotic inventories of terrestrial and aquatic plants in the Toronto area
  
  - Identify taxa using dichotomous keys, morphological features, and habitat
  ]
)

= Education

#grid(
  columns: (1fr, 6fr),
  [2018 -- 2020],
  [
  #smallcaps([Master of Science])
  #v(-5pt)
  #text(style: "oblique")[McGill University]

  *Thesis*: #link("https://escholarship.mcgill.ca/concern/theses/jh343x41s")[Elevational patterns in seed fates: experimental tests in the Rocky Mountains]
  ]
)

#grid(
  columns: (1fr, 6fr),
  [2013 -- 2017],
  [
  #smallcaps([Bachelor of Science in Environmental Sciences])
  #v(-5pt)
  #text(style: "oblique")[University of Guelph]
  
  *Thesis*: #link("https://www.journals.uchicago.edu/doi/abs/10.1086/716783")[Influence of Arbuscular Mycorrhizal Fungi on Root Allocation and Morphology in Two _Medicago_ Species]
  ]
)

= Skills

#table(
  columns: (1fr, 1fr, 1fr),
  stroke: none,
  column-gutter: 1em,
  inset: (x: 0pt),
  [- Natural language processing],
  [- Machine learning],
  [- Data engineering],
  [- Shiny apps],
  [- Workflow orchestration],
  [- Environment management],
  [- Data visualization],
  [- Containerization],
  [- Dashboarding],
)

// Define a function to create skill rating bars
#let skill_bar(filled: 5, total: 5, fill_color: blue, empty_color: gray) = {
  stack(
    dir: ltr,
    spacing: 2.5pt,
    ..range(total).map(i => 
      box(
        width: 8pt, 
        height: 8pt, 
        fill: if i < filled { fill_color } else { empty_color }
      )
    )
  )
}

// Define skills data structure
#let computer_languages = (
  ("R", 5),
  ("Git", 4),
  ("SQL", 4), 
  ("HTML", 3),
  ("Bash", 3),
  ("Python", 2),
  ("Docker", 2),
  ("CSS", 2),
  ("JavaScript", 1),
)

// Create the skills section
= Computer Languages

#table(
  columns: (1fr, 2fr) * 3, 
  stroke: none,
  align: (right + horizon, left + horizon) * 3,
  inset: (x: 8pt, y: 4pt),
  
  ..computer_languages.chunks(3).map(chunk => 
    chunk.map(((name, rating)) => (name, skill_bar(filled: rating)))
  ).flatten()
)

// Option 1: Using a modified data structure with labels
#let languages = (
  ("English", 5, "Native proficiency"),
  ("French", 2, "B-certified")
)

= Languages

#table(
  columns: (1fr, 2fr) * 3, // Only 2 columns since we have 2 languages
  stroke: none,
  align: (right + horizon, left + horizon) * 2,
  inset: (x: 8pt, y: 4pt),
  
  [English], 
  stack(
    spacing: 4pt,
    skill_bar(filled: 5),
    text(size: 8pt, style: "italic")[Native proficiency]
  ),
  
  [French], 
  stack(
    spacing: 4pt,
    skill_bar(filled: 2),
    text(size: 8pt, style: "italic")[B-certified]
  )
)