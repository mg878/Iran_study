# Iran_study
M. Ghafari et al.: Ongoing outbreak of COVID-19 in Iran: challenges and signs of concern with under-reporting of prevalence and deaths

## Codes

`Benford.m`: MATLAB code and data for Benford's Law (BL) analysis

`MLE_Estimate.m`: MATLAB code that computes the maximum likelihood estimate of the outbreak size.

`excessDeaths_analysis.R`: R code for excess mortality analysis.

## Data

`Genome_metadata.xlsx`: this contains the metadata from GISAID used for the phylogenetic analysis

`Reported_cases&deaths.xlsx`: this includes a time series data (obtained from the Johns Hopkins Coronavirus Resource Center) for the number of confirmed cases and deaths in Iran, UK, US, France, Italy, and Spain as well as daily confirmed cases in Guangdong, Shanghai, Beijing, and Hubei.

`Province_cases.xlsx`: this contains the number of provincial confirmed cases in Iran from Feb 19 to Mar 22.

`Number_of_passengers.xlsx`: this includes the flight information from 4 of the largests airports in Iran (Tehran, Isfahan, Shiraz, and Mashhad) to countries with detected cases from Iran (UAE, Lebanon, China, Kuwait, and UAE) and also contains information regarding approximate aircraft capacities per flight.

`Iran_data.xlsx`: this includes the daily number of confirmed cases (outpatients and hospitalised), deaths, and tests taken.

`Catchment_population.xlsx`: this includes the provincial population size (including those from the catchment population of the airports highlighted in yellow boxes) based on the 2016 national census.

`simulation_results.xlsx`: this includes a detailed output of our SEIR modelling (exported from covid19-scenarios.org dashboard). The file includes dates, confirmed weekly cases, confirmed weekly deaths, effective reproduction number, severe cases, exposed individuals, infectious individuals, severely ill individuals (hospitalised), individuals in the ICU, weekly fatalities, cumulative recovered, and cumulative fatalities with their corresponding 95% CI (upper and lower bounds). 

`Iran_seqs_removed.xml`: this includes the BEAST v1.10 XML file for the phylogenetic analysis.

`Iran_seqs_removed.log`: this includes the log file, output of the BEAST simulation.