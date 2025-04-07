
#load packages----
library(tidyverse)
library(readxl)
library(janitor)



# #clean raw data

jul24 <- read_excel("C:/Users/4477078/OneDrive - Moffitt Cancer Center/kdr_app/data/kdr_provider_jul24.xlsx")
aug24 <- read_excel("C:/Users/4477078/OneDrive - Moffitt Cancer Center/kdr_app/data/kdr_provider_aug24.xlsx")
sep24 <- read_excel("C:/Users/4477078/OneDrive - Moffitt Cancer Center/kdr_app/data/kdr_provider_sep24.xlsx")
oct24 <- read_excel("C:/Users/4477078/OneDrive - Moffitt Cancer Center/kdr_app/data/kdr_provider_oct24.xlsx")
nov24 <- read_excel("C:/Users/4477078/OneDrive - Moffitt Cancer Center/kdr_app/data/kdr_provider_nov24.xlsx")
dec24 <- read_excel("C:/Users/4477078/OneDrive - Moffitt Cancer Center/kdr_app/data/kdr_provider_dec24.xlsx")
jan25 <- read_excel("C:/Users/4477078/OneDrive - Moffitt Cancer Center/kdr_app/data/kdr_provider_jan25.xlsx")
feb25 <- read_excel("C:/Users/4477078/OneDrive - Moffitt Cancer Center/kdr_app/data/kdr_provider_feb25.xlsx")
mar25 <- read_excel("C:/Users/4477078/OneDrive - Moffitt Cancer Center/kdr_app/data/kdr_provider_mar25.xlsx")

questions <- read_excel("C:/Users/4477078/OneDrive - Moffitt Cancer Center/kdr_app/data/questions.xlsx")

questions <- questions %>%
  clean_names() %>%
  rename(question = question_text_latest) %>%
  filter(varname != "NA" )

##combine rows of data tables

data<-rbind(jul24, aug24, sep24, oct24, nov24, dec24, jan25, feb25, mar25)

data<-data %>%
  clean_names() %>%
  filter (survey_id != "NA") %>%
  as.data.frame() %>%
  rename(npi = npi_num,
         name = provider_nm,
         type = provider_type,
         date = recdate,
         question = question_text_latest,
         top_box = top_box_ind) %>%
  mutate(date = as.Date(date)) %>%
  mutate(response = as.numeric(response)) %>%
  mutate(npi = as.character(npi))

save(data,file="G:/Press Ganey II/Reports/Ad Hoc/DEEP DIVE/Key Driver Reports/data/provider_072024-032025.Rdata")
save(questions,file="G:/Press Ganey II/Reports/Ad Hoc/DEEP DIVE/Key Driver Reports/data/questions.Rdata")
