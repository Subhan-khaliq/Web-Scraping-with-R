library(tidyverse)
library(xml2)
library(rvest)
library(dplyr)
K = data.frame()
for(page_no in seq(from = 1, to = 3 , by =1))
{
  link =paste0("https://www.amazon.com/s?k=laptop+dell+core+i7+10th+generation&i=computers-intl-ship&bbn=16225007011&rh=p_89%3ADell&dc",page_no,"&crid=1H4M558GXNOTI&qid=1607541492&rnid=2528832011&sprefix=laptop+dell+core%2Ccomputers-intl-ship%2C642&ref=sr_pg_1")
  page = read_html(link)
  prices = page %>% html_nodes(".a-price-whole") %>% html_text()
  names = page %>% html_nodes(".a-color-base.a-text-normal") %>% html_text()
  prices=as.numeric(prices)
  K = rbind(K, data.frame(names,prices, stringsAsFactors = FALSE))
}
K[is.na(K)]=0
write.csv(K)
boxplot(K["prices"],varwidth = TRUE, las = 2,ylab="Price",col="purple")
title("Dell core i7 prices in $ USD")

