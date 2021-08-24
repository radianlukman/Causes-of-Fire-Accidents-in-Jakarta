# Import library
library(readr)
library(ggplot2)
library(dplyr)

# Import data
data <- read_csv("PenyebabKebakaranJakarta.csv")
print(data)

# Melihat nilai unik
unique(data[c("tahun")])
unique(data[c("wilayah")])
unique(data[c("penyebab")])

# Mengubah jenis data
data$tahun <- as.factor(data$tahun)
data$wilayah <- as.factor(data$wilayah)
data$penyebab <- as.factor(data$penyebab)
head(data)

# Melihat missing data
sum(is.na(data))

# Membuat data dalam pertahun
pertahun <- aggregate(jumlah~tahun, data, sum)
ggplot(pertahun, aes(x=tahun,y=jumlah,group=1)) +
  geom_line(stat='identity',color='red',size=1.5) + 
  geom_point() +
  geom_text(aes(label=jumlah),hjust=1.2, color="black", size=6, parse=TRUE) +
  ggtitle("Jumlah Kejadian Kebakaran di DKI Jakarta \n 2015-2020") +
  labs(x='Tahun',y='Jumlah') +
  theme(plot.title = element_text(hjust = 0.5,size=20,face='bold'),text = element_text(size=20))

# Membuat trend plot tiap tahun
trend <- data %>%
          group_by(tahun,penyebab) %>%
          summarise(jumlah = sum(jumlah))
ggplot(trend,aes(x = tahun, y = jumlah, colour = penyebab, group = penyebab)) +
  geom_line(size=1.2) +
  ggtitle("Jumlah Kejadian Kebakaran di DKI Jakarta \n2015-2020") +
  labs(x='Tahun',y='Jumlah') +
  theme(plot.title = element_text(hjust = 0.5,size=15,face='bold'),text = element_text(size=15)) +
  scale_colour_brewer(palette="Set1") 

# Membuat Bar chart Penyebab Kebakaran
penyebab <- aggregate(jumlah~penyebab, data, sum)
ggplot(penyebab, aes(x=reorder(penyebab,jumlah),y=jumlah)) +
  geom_bar(stat="identity", fill='steelblue') +
  geom_text(aes(label=jumlah),hjust=1, color="black", size=6, parse=TRUE) +
  ggtitle("Jumlah Kejadian Kebakaran di DKI Jakarta \nBerdasarkan Penyebab") +
  labs(x='Penyebab',y='Jumlah') +
  theme(plot.title = element_text(hjust = 0.5,size=15,face='bold'),text = element_text(size=15)) +
  coord_flip()

# Membuat Bar chart Penyebab Kebakaran berdasarkan wilayah
wilayah <- aggregate(jumlah~wilayah,data,sum)
ggplot(wilayah, aes(x=reorder(wilayah,jumlah),y=jumlah)) +
  geom_bar(stat="identity", fill='steelblue') +
  geom_text(aes(label=jumlah),hjust=1, color="black", size=6, parse=TRUE) +
  ggtitle("Jumlah Kejadian Kebakaran di DKI Jakarta \nBerdasarkan Kabupaten/Kota Administrasi") +
  labs(x='Kabupaten/Kota Administrasi',y='Jumlah') +
  theme(plot.title = element_text(hjust = 0.5,size=15,face='bold'),text = element_text(size=15)) +
  coord_flip()

# Bar chart Jumlah Kejadian Kebakaran berdasarkan penyebab per tahun
ggplot(data, aes(x=penyebab,y=jumlah,fill=penyebab)) +
  geom_bar(stat="identity") +
  ggtitle("Jumlah Kejadian Kebakaran di DKI Jakarta Berdasarkan Penyebabnya \nDikelompokkan per Tahun") +
  labs(x='Penyebab',y='Jumlah') +
  theme(plot.title = element_text(hjust=0.5,size=15,face='bold'),axis.text.x=element_text(angle = 90,vjust = 0.5, hjust=1),text = element_text(size=15)) + 
  facet_wrap(~tahun)

# Bar chart Jumlah Kejadian Kebakaran berdasarkan penyebab per kabupaten/kota administrasi
ggplot(data, aes(x=penyebab,y=jumlah,fill=penyebab)) +
  geom_bar(stat="identity") +
  ggtitle("Jumlah Kejadian Kebakaran di DKI Jakarta Berdasarkan Penyebabnya \nDikelompokkan per Kabupaten/Kota Administrasi") +
  labs(x='Penyebab',y='Jumlah') +
  theme(plot.title = element_text(hjust=0.5,size=15,face='bold'),axis.text.x=element_text(angle = 90,vjust = 0.5, hjust=1),text = element_text(size=15)) + 
  facet_wrap(~wilayah) 

# Bar chart Jumlah Kejadian Kebakaran berdasarkan kabupaten/kota administrasi per tahun
ggplot(data, aes(x=wilayah,y=jumlah,fill=wilayah)) +
  geom_bar(stat="identity") +
  ggtitle("Jumlah Kejadian Kebakaran di DKI Jakarta \nBerdasarkan Kabupaten/Kota Administrasi \nDikelompokkan per Tahun") +
  labs(x='Kabupaten/Kota Administrasi',y='Jumlah') +
  theme(plot.title = element_text(hjust=0.5,size=15,face='bold'),axis.text.x=element_text(angle = 90,vjust = 0.5, hjust=1),text = element_text(size=15)) + 
  facet_wrap(~tahun) 