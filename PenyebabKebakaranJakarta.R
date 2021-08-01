# Import library
library(readr)
library(ggplot2)
library(dplyr)

# Import data
data <- read_csv("PenyebabKebakaranJakarta.csv")
head(data)

# Mengubah jenis data
data$tahun <- as.factor(data$tahun)
data$wilayah <- as.factor(data$wilayah)
data$penyebab <- as.factor(data$penyebab)
head(data)

sum(is.na(data))

# Membuat data dalam pertahhun
pertahun <- data %>%
              group_by(tahun) %>%
              summarise(jumlah = sum(jumlah))
pertahun

ggplot(data=pertahun,aes(x=tahun, y=jumlah,group=1)) +
  geom_line(color='red',size=1.5) +
  ggtitle("Jumlah Kasus Kebakaran di DKI Jakarta \n 2015-2020") +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x='Tahun',y='Jumlah')

# Membuat trend plot tiap
trend <- data %>%
          group_by(tahun,penyebab) %>%
          summarise(jumlah = sum(jumlah))

ggplot(trend,aes(x = tahun, y = jumlah, colour = penyebab, group = penyebab)) +
  geom_line(size=1.2) +
  scale_colour_brewer(palette="Set1")

