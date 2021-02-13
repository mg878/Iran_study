# Iran_study
M. Ghafari et al.: Ongoing outbreak of COVID-19 in Iran: challenges and signs of concern with under-reporting of prevalence and deaths

## Codes

`Benford.m`: MATLAB code and data for Benford's Law (BL) analysis

`MLE_Estimate.m`: MATLAB code that computes the maximum likelihood estimate of the outbreak size.

`excessDeaths_analysis.R`: R code for excess mortality analysis.

## Data

`Data_S1.xlsx`: this contains the metadata from GISAID used for the phylogenetic analysis

`Data_S2.xlsx`: this includes a time series data for the number of confirmed cases and deaths in Iran (including the 31 provinces), UK, US, France, Italy, and Spain as well as daily confirmed cases in Guangdong, Shanghai, Beijing, and Hubei.

`Data_S3.xlsx`: this includes a detailed list of all flights from airports in Tehran, Isfahan, Shiraz, and Mashhad to Oman, UAE, Kuwait, Lebanon, and China. The list also includes flight numbers which enables us to find the approximate seating capacity based on aircraft model.

`Data_S4.xlsx`: this includes the approximate population of 17 provinces that use the 4 airports in Iran for international travels.

`Data_S5.xlsx`: this includes a detailed output of our SEIR modelling (exported from covid19-scenarios.org dashboard). The file includes dates, confirmed weekly cases, confirmed weekly deaths, effective reproduction number, severe cases, exposed individuals, infectious individuals, severely ill individuals (hospitalised), individuals in the ICU, weekly fatalities, cumulative recovered, and cumulative fatalities with their corresponding 95% CI (upper and lower bounds).

`BEAST_Iran.xml`: this includes the XML input file for the phylogenetic analysis of the TMRCA/doubling time of the returned travellers' clade using the genomes we collected from Iran and 20 additional genomes from returned travellers.

`BEAST_Iran.log`: this includes the output log file of BEAST v1.10 for the `BEAST_Iran.xml` dataset.

`BEAST_WholeClade.xml`: this includes the XML input file, using the entire dataset of genomes from inside Iran that belong to the returned travellers' clade, for the phylogenetic analysis (*data not shown in the paper*).

`BEAST_WholeClade.log`: this includes the output log file of BEAST v1.10 for the `BEAST_WholeClade.xml` dataset (*data not shown in the paper*).

`RAxML_bootstrap_World.tree`: this includes the maximum likelihood tree with 100 bootstrap values for the globally representative sample of 802 genomes.

`MAP_BEAST.tree`: this includes the maximum a posteriori tree (MAP) of the BEAST analysis using the `BEAST_Iran.xml` dataset.
