library(tidyverse)
library(xml2)
library(rvest)
library(dplyr)
m = data.frame()
for(page_no in seq(from = 1, to = 3 , by =1))
{
  link =paste0("https://www.amazon.com/s?k=laptop+hp+core+i7+10th+generation&i=computers-intl-ship&bbn=16225007011&rh=p_89%3AHP&dc",page_no,"&qid=1607544531&rnid=2528832011&ref=sr_nr_p_89_1")
  page = read_html(link)
  prices = page %>% html_nodes(".a-price-whole") %>% html_text()
  names = page %>% html_nodes(".a-color-base.a-text-normal") %>% html_text()
  prices=as.numeric(sub(",","",prices))
  m = rbind(m, data.frame(names,prices, stringsAsFactors = FALSE))
}
write.csv(m,"Laptops.csv")
m[is.na(m)]=0
boxplot(m["prices"],varwidth = TRUE, las = 2,ylab="Price",col="red")
title("HP core i7 prices in $ USD")

