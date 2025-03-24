#Load data dan simpan ke dalam variable bernama ‘data’
# data <- read.csv("https://storage.googleapis.com/dqlab-dataset/transaksi_stok_dan_penjualan.tsv", header = TRUE, sep = "\t")
data <- read.csv("initial_exploration.r", header = TRUE, sep = "\t")

#Tampilkan 5 data teratas 
head(data,5)

#Tampilkan 5 data terbawah 
tail(data,5)

#Tampilkan informasi mengenai struktur dari data
str(data)


# Modifikasi Data
#Ubah tipe data variabel Tanggal menjadi date
data$Tanggal <- as.Date(data$Tanggal, "%d-%m-%Y")

#Cek apakah tipe data dari variabel Tanggal sudah menjadi date
str(data$Tanggal)

#Tambahkan kolom baru untuk menyimpan data bulan dan tahun
data$Bulan_Tahun <- format(data$Tanggal, "%m-%Y")

#Tampilkan 5 data teratas
head(data, 5)

# Visualisasi Data
# Perubahan Tipe Data
#Ubah tipe data variabel Harga menjadi numerik
data$Harga <- as.numeric(data$Harga)

#Ubah data NA menjadi 0
data$Harga[is.na(data$Harga)] <- 0

#Cek apakah tipe data dari variabel Harga sudah menjadi tipe numerik
str(data$Harga)

#Tampilkan 5 data teratas
head(data, 5)

#Lalu ambillah data dengan jenis transaksi adalah Penjualan
data_penjualan = data[data$Jenis.Transaksi=="Penjualan",]

#Lakukan fungsi aggregasi data untuk mendapatkan penjualan perbulan
penjualan_perbulan = aggregate(x = data_penjualan$Jumlah, 
                     by = list(Bulan_Tahun = data_penjualan$Bulan_Tahun),
                     FUN = sum)

#Keluarkan bar plot dari penjualan perbulan
barplot(penjualan_perbulan$x,
        names.arg =penjualan_perbulan$Bulan_Tahun,
        xlab="Month",
        ylab="Penjualan",
        col="blue",
        main="Penjualan perbulan",
        border="red")
