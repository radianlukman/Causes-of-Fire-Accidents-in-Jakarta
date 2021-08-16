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
pertahun <- aggregate(jumlah~tahun, data, sum)
ggplot(pertahun, aes(x=tahun,y=jumlah,group=1)) +
  geom_line(stat='identity',color='red',size=1.5) + 
  geom_point() +
  geom_text(aes(label=jumlah),hjust=1.2, color="black", size=6, parse=TRUE) +
  ggtitle("Jumlah Kasus Kebakaran di DKI Jakarta \n 2015-2020") +
  labs(x='Tahun',y='Jumlah') +
  theme(plot.title = element_text(hjust = 0.5)) +

# Membuat trend plot tiap
trend <- data %>%
          group_by(tahun,penyebab) %>%
          summarise(jumlah = sum(jumlah))
ggplot(trend,aes(x = tahun, y = jumlah, colour = penyebab, group = penyebab)) +
  geom_line(size=1.2) +
  ggtitle("Jumlah Kasus Kebakaran di DKI Jakarta \nBerdasarkan Penyebab Tiap Tahun") +
  labs(x='Tahun',y='Jumlah') +
  theme(plot.title = element_text(hjust=0.5)) +
  scale_colour_brewer(palette="Set1") 


# Membuat Bar Plot Penyebab Kebakaran
penyebab <- aggregate(jumlah~penyebab, data, sum)
ggplot(penyebab, aes(x=reorder(penyebab,jumlah),y=jumlah)) +
  geom_bar(stat="identity", fill='steelblue') +
  geom_text(aes(label=jumlah),hjust=1, color="black", size=6, parse=TRUE) +
  ggtitle("Jumlah Kasus Kebakaran di DKI Jakarta \nBerdasarkan Penyebab") +
  labs(x='Penyebab',y='Jumlah') +
  theme(plot.title = element_text(hjust=0.5)) +
  coord_flip()

# Membuat Bar plot Penyebab Kebakaran berdasarkan wilaya
wilayah <- aggregate(jumlah~wilayah,data,sum)
ggplot(wilayah, aes(x=reorder(wilayah,jumlah),y=jumlah)) +
  geom_bar(stat="identity", fill='steelblue') +
  geom_text(aes(label=jumlah),hjust=1, color="black", size=6, parse=TRUE) +
  ggtitle("Jumlah Kasus Kebakaran di DKI Jakarta \nBerdasarkan Kabupaten/Kota Administrasi") +
  labs(x='Kabupaten/Kota Administrasi',y='Jumlah') +
  theme(plot.title = element_text(hjust=0.5)) +
  coord_flip()

# Membuat bar chart jumlah kebakaran berdarkan jenisnya tiap tahun
facet1 <- aggregate(jumlah~penyebab, data, sum)

ggplot(data, aes(x=penyebab,y=jumlah,fill=penyebab)) +
  geom_bar(stat="identity") +
  ggtitle("Jumlah Kasus Kebakaran di DKI Jakarta Berdasarkan Penyebabnya \nDikelompokkan per Tahun") +
  labs(x='Penyebab',y='Jumlah') +
  theme(plot.title = element_text(hjust=0.5),axis.text.x=element_text(angle = 90,vjust = 0.5, hjust=1)) + 
  facet_wrap(~tahun, scales='fixed')

ggplot(data, aes(x=penyebab,y=jumlah,fill=penyebab)) +
  geom_bar(stat="identity") +
  ggtitle("Jumlah Kasus Kebakaran di DKI Jakarta Berdasarkan Penyebabnya \nDikelompokkan per Kabupaten/Kota Administrasi") +
  labs(x='Penyebab',y='Jumlah') +
  theme(plot.title = element_text(hjust=0.5),axis.text.x=element_text(angle = 90,vjust = 0.5, hjust=1)) + 
  facet_wrap(~wilayah) 

ggplot(data, aes(x=wilayah,y=jumlah,fill=wilayah)) +
  geom_bar(stat="identity") +
  ggtitle("Jumlah Kasus Kebakaran di DKI Jakarta Berdasarkan Kabupaten/Kota Administrasi \nDikelompokkan per Kabupaten/Kota Administrasi") +
  labs(x='Kabupaten/Kota Administrasi',y='Jumlah') +
  theme(plot.title = element_text(hjust=0.5),axis.text.x=element_text(angle = 90,vjust = 0.5, hjust=1)) + 
  facet_wrap(~tahun) 
