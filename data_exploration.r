#Load data dan simpan ke dalam variable bernama ‘data’
# data <- read.csv("https://storage.googleapis.com/dqlab-dataset/transaksi_stok_dan_penjualan.tsv", header = TRUE, sep = "\t")
data <- read.csv("initial_exploration.r", header = TRUE, sep = "\t")

# 1
#Tentukan 10 customer mana saja yang memiliki pembelian terbesar!
#Keluarkan data dengan jenis transaksi adalah Penjualan
data_penjualan = data[data$Jenis.Transaksi=="Penjualan",]

#Lakukan fungsi aggregasi data untuk mendapatkan pembelian per customer
pembelian_pelanggan=aggregate(
             x=data_penjualan$Jumlah,
             by =list(Pelanggan = data_penjualan$Nama.Pelanggan),
             FUN = sum)

#Urutkan data pelanggan berdasarkan jumlah pembelian dari yang terbesar ke yang terkecil
pembelian_pelanggan = pembelian_pelanggan[order(-pembelian_pelanggan$x), ]

#Ambil 10 nilai tertinggi dari data diatas
head(pembelian_pelanggan, 10)

#Perbandingan barang masuk dan keluar perbulan
aggregate(
  x=data$Jumlah, 
  by = list(Bulan = data$Bulan_Tahun, Jenis_Transaksi = data$Jenis.Transaksi), 
  FUN = sum)

#Visualisasikan data dengan chart yang sesuai
#Buat tabel transaksi menggunakan fungsi aggregate
data_transaksi = aggregate(
  x=data$Jumlah, 
  by = list(Bulan = data$Bulan_Tahun, Jenis_Transaksi = data$Jenis.Transaksi), 
  FUN = sum)

#Keluarkan data transaksi penjualan dan stok masuk
data_penjualan <- data_transaksi[(data_transaksi$Jenis_Transaksi) == "Penjualan",]
data_stok_masuk <- data_transaksi[(data_transaksi$Jenis_Transaksi) == "Stok Masuk",]

#Gabungkan kedua data diatas menggunakan fungsi merge dengan left join
data_gabungan = merge(data_stok_masuk,data_penjualan,by='Bulan', all.x=TRUE)
data_gabungan = data.frame(Bulan = data_gabungan$Bulan,
                           Stok_Masuk = data_gabungan$x.x,
                           Penjualan = data_gabungan$x.y)

#Periksa apakah terdapat NA data. Jika terdapat NA data, kamu dapat menggantinya dengan 0
data_gabungan$Penjualan[is.na(data_gabungan$Penjualan)] <- 0

#Ubah format data gabungan dengan melakukan perintah transpose. Lalu ubah nama kolom menggunakan bulan
data_gabung = t(as.matrix(data_gabungan[-1]))
colnames(data_gabung) = data_gabungan$Bulan

#Keluarkan bar plot dengan multiple kategori untuk membandingkan stok masuk dengan penjualan. Lalu keluarkan legend dari barplot tersebut.
barplot(data_gabung,
        main='Perbandingan Penjualan dengan Stok Masuk',
        ylab='Jumlah Barang', 
        xlab='Bulan',
        beside = TRUE, 
        col=c("red","blue"))
legend('topright',fill=c("red","blue"),legend=c('Stok Masuk','Penjualan'))

# 2
#Analisis hubungan antara Harga Barang dengan Jumlah Transaksi
#Memilih data dengan jenis transaksi Penjualan
data <- data[(data$Jenis.Transaksi) == "Penjualan",]

#Mengubah data harga menjadi Integer
data$Harga <- as.integer(data$Harga)

#Mengubah nilai NA menjadi 0
data$Harga[is.na(data$Harga)] <- 0

#Menghitung jumlah transaksi berdasarkan rentang harga
data_transaksi <- aggregate(
  x=data$No.Transaksi, 
  by = list(Harga = data$Harga), 
  FUN = length)

#Mengurutkan data dari harga termahal
data_transaksi = data_transaksi[order(-data_transaksi$Harga), ]

#Visualisasi data hubungan harga barang dengan jumlah transaksi
#Sebelum menggunakan perintah hist() kamu perlu memecah data transaksi diatas menjadi bentuk data vektor sebagai berikut
data_transaksi_freq = as.vector(rep(data_transaksi$Harga, data_transaksi$x))

#Setelah mendapatkan data diatas, kita dapat mengeluarkan histogram dari tabel diatas dengan menggunakan perintah hist()
hist(data_transaksi_freq,
     main="Hubungan antara harga barang dengan transaksi",
     xlab="Rentang harga barang",
     col="green"
)