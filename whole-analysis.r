
library(LDATS)
library(RCurl)
library(portalr)
#### Get data #### 
# Functions to download data using portalr and prepare it for LDATS
source('functions/get-data.R')
source('functions/select_LDA.R')
source('functions/run_changepoint_model.R')


# argument time_or_plots says whether to prioritize time (longer time series) or plots (more plots,
# but a shorter timeseries)
# treatment is control or exclosure

#rodent_data = get_rodent_lda_data(time_or_plots = 'time', treatment = 'exclosure')
# using the same data as the paper:
#rodent_data = read.csv('paper_dat.csv', stringsAsFactors = FALSE, colClasses = c('Date', rep('integer', 21)))
#colnames(rodent_data)[1] <- 'date'
 
rodent_data = get_rodent_lda_data(time_or_plots = 'plots', treatment = 'exclosure', type = 'granivores')


selected = run_rodent_LDA(rodent_data = rodent_data, topics_vector = c(2, 3, 4, 5, 6),
                          nseeds = 2, ncores = 4)

changepoint = run_rodent_cpt(rodent_data = rodent_data, selected = selected,
                             changepoints_vector = c(2, 3, 4, 5, 6))

source('functions/lda_plot_function.R')

load('diagnostics_526.Rdata')


composition = community_composition(selected)

P = plot_community_composition_gg(composition,c(1:(selected@k)),ylim=c(0,1))

