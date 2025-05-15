# options(jamovi_home='C:/Program Files/jamovi')
options(jamovi_home='C:/Program Files/jamovi 2.6.26.0')
jmvtools::check()
# jmvtools::addAnalysis(name='umbrella', title='Calculations for an umbrella review')
# getwd()
# https://dev.jamovi.org/tuts0103-creating-an-analysis.html
jmvtools::install()




# MULTILEVEL
aggregate_df( => metaConvert::aggregate_df(
  
# META
metagen( => meta::metagen(

# FOREST
forest( => meta::forest(
metagen( => meta::metagen(
  
  
dat = readxl::read_excel("D:/Downloads/Results__umbrella review_dataset_v8_forestplot_PA SB separate (2).xlsx")

dat$ID = paste0(dat$author, dat$year)

resanx = dat[dat$factor == "Other (Quality of life)", ]
length(unique(resanx$ID))
res = metaumbrella::umbrella(dat, mult.level=TRUE)
View(summary(metaumbrella::add.evidence(res)))  
metaumbrella::forest(res)
