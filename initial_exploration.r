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