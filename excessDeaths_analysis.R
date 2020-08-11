# Alireza kadivar
# July 2020

# This scripts tries to analysis excess deathsin Iran's provinces 
# by fitting linear models for each province for 
# 2019 spring, 2019 summer, 2019 fall, 2020 winter, 2020 spring 
# (the last two are of more interest in this study)
# first peice of scipt focuses on winter 2020 and before that
# the second peice focuses on spring 2020
# structure of the second peice is simmilar to the first peice

# At the end there is aomparison between histograms of winter 2020 and spring 2020

######################

# libraries

library(readr)
library(readxl)
library(data.table)
library(dplyr)
library(ggplot2)
library(scales)
library(extrafont)

# anlaysis

Ds = data.frame(year = as.numeric(), season=as.character(), Region = as.character(),
                pop_death_predicted = as.numeric(), pop_death = as.numeric(),
                up = as.numeric(), low = as.numeric(), 
                region = as.character())

# we need this data to match provinces addresscodes
d_provmatched = read_excel('D:/SMCloud/projects/Blog/deathStats_sabteAhval/iranProvs.xlsx', 
                           sheet = 'matchings')

# season1: spring
# season2: summer
# season3: fall
# season4: winter

# for each season for each province we fit a linear model
# there are two for loops: one for seasons (i) and one for provinces (Region)

for (i in c('4', '3', '2', '1')){
  
  d = read_excel('D:/SMCloud/projects/Blog/deathStats_sabteAhval/92-98.xlsx', sheet = i)

  d = merge(d_provmatched[, c("region", "region_fa")], d, by.x = 'region_fa', by.y = 'region')
  
  d$region_fa = NULL

  dm = melt(d, variable.name = 'year', value.name = 'pop_death', id = 'region')
  dm$season = i
  dm$year = as.numeric(gsub('y', '', dm$year))
  
  # transfering years from Jalali to Gregorian Calendar
  dm$year[dm$season == '4'] = dm$year[dm$season == '4'] + 2020 - 98
  dm$year[dm$season != '4'] = dm$year[dm$season != '4'] + 2019 - 98
  
  # we remove the last year data when fit the linear model 
  # winter (season4) is when the gregorian year changes
  # therefore we memorize it in a variable named last_year
  
  if (i == '4'){
    last_year = 2020
  } else {
    last_year = 2019
  }
  

  for (Region in unique(d$region)){
    
    ds = dm %>% filter(region == Region)
    lm_model = lm(pop_death~year, ds %>% filter(year != last_year))
    pop_death_predicted = predict(lm_model, data.frame(year = last_year))
    pop_death_predicteds = predict(lm_model, ds)
    
    summ = summary(lm_model)
  
    # we use 3 sigma for 95% confidence interval 
    # with the assumption of normality of residuals around the fitted line
    # up and low are upper and lower bound f CI
    
    Ds_temp = data.frame(year=last_year, season=i, Region = Region,
                         pop_death_predicted = pop_death_predicted, 
                         pop_death = ds$pop_death[ds$year == last_year],
                         up = ds$pop_death[ds$year == last_year] + 3*summ$sigma,
                         low = ds$pop_death[ds$year == last_year] - 3*summ$sigma)
    
    Ds = rbind(Ds, Ds_temp)
    
    
    # plot:
    ggplt = 
      ggplot(data = ds, aes(year, pop_death))+
      geom_ribbon(data = ds, aes(year, 
                                 ymin = pop_death_predicteds-3*summ$sigma, 
                                 ymax = pop_death_predicteds+3*summ$sigma), 
                  fill = 'gray50', alpha = .3)+
        geom_smooth(data = rbind(ds %>% filter(year != last_year), 
                                 data.frame(year = last_year, 
                                            pop_death = pop_death_predicted,
                                            region = Region,
                                            season = i)), 
                   aes(year, pop_death), method = 'lm', 
                   linetype = 'dashed', se = F, size = 1.2)+
        geom_point(size = 3.5, color = 'blue3', alpha = .87)+
      xlab('')+
      ylab('Registered death toll
           ')+
        geom_point(data = ds %>% filter(year == last_year), 
                   aes(year, pop_death), 
                   size = 4, alpha = .6,
                   color = ifelse(Ds_temp$low > Ds_temp$pop_death_predicted | 
                                    Ds_temp$up < Ds_temp$pop_death_predicted, 
                                  'darkred', 'black'))+
      theme_minimal(base_family = 'Garamond', base_size = 25)+
      theme(plot.title = element_text(face = "bold"))+
      scale_y_continuous(labels = comma)+
      ggtitle(paste(Region, 'Province'), 
              subtitle = paste('', ifelse(i=='1', 'Spring',
                                             ifelse(i == '2', 'Summer',
                                                    ifelse (i== '3', 'Fall',
                                                            ifelse(i == '4', 'Winter', ''))))
              ))
    
    
  ggsave(filename = paste0(Region,'_', i, '.png'), plot = ggplt, 
         width = 200, height = 125, device = 'png', units = "mm", 
         path = 'D:/SMCloud/projects/Blog/139904 - ExcessDeath ScienceAdvances/img_984/')
  print(paste0(Region,'_', i, '.png'))
  }
}

Ds$up = Ds$up - Ds$pop_death_predicted
Ds$low = Ds$low - Ds$pop_death_predicted

# if the CI includes 0 we consider it as a significant difference

Ds$sign_up = Ds$low > 0
Ds$sign_low = Ds$up < 0
Ds$excess_death = Ds$pop_death - Ds$pop_death_predicted
Ds$excess_death_percent = Ds$excess_death / Ds$pop_death_predicted
write_excel_csv(Ds, 'D:/SMCloud/projects/Blog/139904 - ExcessDeath ScienceAdvances/provResults_984.csv')

Ds984 = Ds

#########################
############################################
#################################
################


# Spring 99

Ds = data.frame(year = as.numeric(), season=as.character(), Region = as.character(),
                pop_death_predicted = as.numeric(), pop_death = as.numeric(),
                up = as.numeric(), low = as.numeric(), 
                region = as.character())

i = '1'

for (i in c('1')){
  
  d = read_excel('D:/SMCloud/projects/Blog/139904 - sabteAhvalDeaths/92-99.xlsx', sheet = i)

  d = merge(d_provmatched[, c("region", "region_fa")], d, by.x = 'region_fa', by.y = 'region')
  
  d$region_fa = NULL
  
  dm = melt(d, variable.name = 'year', value.name = 'pop_death', id = 'region')
  dm$season = i
  dm$year = as.numeric(gsub('y', '', dm$year))
  
  dm$year[dm$season == '1'] = dm$year[dm$season == '1'] + 2020 - 99
  
  last_year = 2020

#  Region = unique(d$region)[1]
  for (Region in unique(d$region)){
    
    ds = dm %>% filter(region == Region)
    lm_model = lm(pop_death~year, ds %>% filter(year != last_year))
    pop_death_predicted = predict(lm_model, data.frame(year = last_year))
    pop_death_predicteds = predict(lm_model, ds)
    
    
    summ = summary(lm_model)
    
    Ds_temp = data.frame(year=last_year, season=i, Region = Region,
                         pop_death_predicted = pop_death_predicted, 
                         pop_death = ds$pop_death[ds$year == last_year],
                         up = ds$pop_death[ds$year == last_year]  + 3*summ$sigma,
                         low = ds$pop_death[ds$year == last_year] - 3*summ$sigma)
    
    Ds = rbind(Ds, Ds_temp)
    
    ggplt = 
    ggplot(data = ds, aes(year, pop_death))+
      geom_ribbon(data = ds, aes(year, 
                                 ymin = pop_death_predicteds-3*summ$sigma, 
                                 ymax = pop_death_predicteds+3*summ$sigma), 
                  fill = 'gray50', alpha = .3)+
      geom_smooth(data = rbind(ds %>% filter(year != last_year), 
                               data.frame(year = last_year, 
                                          pop_death = pop_death_predicted,
                                          region = Region,
                                          season = i)), 
                  aes(year, pop_death), method = 'lm', 
                  linetype = 'dashed', se = F, size = 1.2)+
      geom_point(size = 3.5, color = 'blue3', alpha = .87)+
      xlab('')+
      ylab('Registered death toll
           ')+
      geom_point(data = ds %>% filter(year == last_year), 
                 aes(year, pop_death), 
                 size = 4, alpha = .6,
                 color = ifelse(Ds_temp$low > Ds_temp$pop_death_predicted | 
                                  Ds_temp$up < Ds_temp$pop_death_predicted, 
                                'darkred', 'black'))+
      theme_minimal(base_family = 'Garamond', base_size = 25)+
      theme(plot.title = element_text(face = "bold"))+
      scale_y_continuous(labels = comma)+
      ggtitle(paste(Region, 'Province'), 
              subtitle = paste('', ifelse(i=='1', 'Spring',
                                          ifelse(i == '2', 'Summer',
                                                 ifelse (i== '3', 'Fall',
                                                         ifelse(i == '4', 'Winter', ''))))
              ))
    


    ggsave(filename = paste0(Region,'_', i, '.png'), plot = ggplt, 
           width = 200, height = 125, device = 'png', units = "mm", 
           path = 'D:/SMCloud/projects/Blog/139904 - ExcessDeath ScienceAdvances/img_991/')
    print(paste0(Region,'_', i, '.png'))
  }
}

Ds$up = Ds$up - Ds$pop_death_predicted
Ds$low = Ds$low - Ds$pop_death_predicted


Ds$sign_up = Ds$low > 0
Ds$sign_low = Ds$up < 0
Ds$excess_death = Ds$pop_death - Ds$pop_death_predicted
Ds$excess_death_percent = Ds$excess_death / Ds$pop_death_predicted
write_excel_csv(Ds, 'D:/SMCloud/projects/Blog/139904 - ExcessDeath ScienceAdvances/provResults_991.csv')


#########################
#########################

########## histograms

Ds991 = Ds
DS = rbind(Ds984, Ds991)

DS$Season[DS$season == 4] = 'Winter'
DS$Season[DS$season == 1] = 'Spring'

DS$yearsem = paste(DS$season, DS$year)

ggplt =
  ggplot(DS %>% filter(year %in% 2019:2020), aes(excess_death_percent))+
    geom_histogram(bins = 28, alpha = .85, fill = 'deepskyblue4')+
  scale_x_continuous(labels = percent, limits = c(-0.2, 0.7))+
    facet_grid(yearsem~.)+
  theme_minimal(base_family = 'Garamond', base_size = 25)+
  theme(plot.title = element_text(face = "bold"))+
  xlab('Excess Death Percent')+
  ggtitle('Province Excess Deaths Percent Histogram',
          subtitle = 'Comparing Spring to Winter 2020')


# ggsave(filename = paste0('histogramAll2', '.png'), plot = ggplt,
#        width = 250, height = 225, device = 'png', units = "mm",
#        path = 'D:/SMCloud/projects/Blog/139904 - ExcessDeath ScienceAdvances/')

