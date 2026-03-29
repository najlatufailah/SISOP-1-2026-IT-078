# praktikum-1-sisop

### Najla Tufailah  (5027251078)
### Soal 1

Pada bagian awal ini memakai kode agar tidak dianggap file, yang mana data diambil dari baris ke-2 atau nama orang pertama
```c
BEGIN {
    FS=","
    mode = ARGV[2]   # ambil a/b/c/d/e
    ARGV[2] = ""     # hapus biar gak dianggap file
}

# skip header
NR==1 { next }

```

Lalu pada bagian ini menambahkan a/b/c/d/e yang mana :
* a untuk menghitung total penumpang
* b untuk menghitung jumlah gerbong yang ada
* c untuk melihat umur penumopang tertua
* d untuk menghitung rata-rata umur penumpang
* e untuk menghitung jumlah penumpang business class
```c
# MODE A — jumlah penumpang
mode=="a" {
    count++
}

# MODE B — jumlah gerbong unik
mode=="b" {
    carriage[$4] = 1
}

# MODE C — penumpang tertua
mode=="c" {
    if ($2 > max_age) {
        max_age = $2
        oldest = $1
    }
}

# MODE D — rata-rata usia
mode=="d" {
    total_age += $2
    total++
}

# MODE E — business class
mode=="e" && ($3=="Business" || $3=="business") {
    business++
}
```
Menjalankan setelah semua data dibaca

```c
END {
```
Menapilkan output a yaitu total penumpang
```c
if (mode=="a") {
        print "Jumlah seluruh penumpang KANJ adalah " count " orang"
    }
```
Menapilkan output b yaitu jumlah gerbong

```c
else if (mode=="b") {
        for (c in carriage) total_carriage++
        print "Jumlah gerbong penumpang KANJ adalah " total_carriage
    }
```
Menampilkan output c yaitu umur oenumpang tertua
```c
else if (mode=="c") {
        print oldest " adalah penumpang kereta tertua dengan usia " max_age " tahun"
    }
```
Menapilkan output d yaotu rata rata umur penumpang
```celse if (mode=="d") {
        avg = int(total_age / total)
        print "Rata-rata usia penumpang adalah " avg " tahun"
    }
```
Menampilkan jumlah penumpang business class
```c
else if (mode=="e") {
        print "Jumlah penumpang business class adalah " business " orang"
    }
```
Menapilkan jika tidak ada didalam pilihan a/b/c/d/e
```c
else {
        print "Soal tidak dikenali. Gunakan a, b, c, d, atau e."
    }
}
```
Output 

<img width="606" height="179" alt="Tangkapan Layar 2026-03-29 pukul 18 52 14" src="https://github.com/user-attachments/assets/e6e28b3d-f48f-4e30-a47e-b77a86a24eba" />


**Kendala**
Kadang kode tak terbaca

### REVISI - PENAMBAHAN SOAL_2

Soal ini disuruh untuk menyelesaikan misi ekspedisi dengan cara:
1. Mengambil data dari file JSON (`gsxtrack.json`)
2. Mengekstrak titik-titik penting (site_name dan koordinat)
3. Menyusun data dalam format tertentu
4. Menghitung titik tengah (midpoint) dari koordinat untuk menemukan lokasi pusaka

**Penjelasan Script parserkoordinat.sh**

Script ini digunakan untuk melakukan parsing data dari file `gsxtrack.json` dan mengubahnya menjadi format yang lebih terstruktur.



Bagian ini berfungsi untuk:
* Mendeteksi baris yang mengandung site_name
* Mengambil nilai nama lokasi
* Menghapus karakter yang tidak diperlukan
* Menyimpan hasil ke variabel site
```c
/"site_name"/ {
    split($0, a, ": ")
    gsub(/[",]/, "", a[2])
    site=a[2]
}
```

Digunakan untuk mendeteksi baris yang berisi koordinat lokasi. lalu kode tersebut mengambil isi koordinat dalam tanda [], memisahkan longitude, lalu koordinar dipisahkan menjadi longitude dan latitude, lalu menghapus spasi agar format rapi

```c
/"coordinates"/ {
    match($0, /\[.*\]/)
    coords=substr($0, RSTART+1, RLENGTH-2)
    split(coords, c, ",")
    lon=c[1]
    lat=c[2]

    gsub(/ /, "", lat)
    gsub(/ /, "", lon)
```

lalu menyusun dan menampilkan output dalam format yang ditentukan
```c
printf "node_%03d,%s,%s,%s\n", ++i, site, lat, lon
}
' $input > $output

echo "Berhasil parsing koordinat!"
```
**Penjelasan Script nemupusaka.sh**

bagian ini mengambil baris dan ketiga dari file, kedua titik dianggap sebagai titik diagonal dari persegi, lalu mengambil nilai latitude dari kolom ke-3, dan longitude dari kolom ke-4, Mengambil nilai koordinat dari titik ketiga dengan cara yang sama, Melakukan perhitungan midpoint dengan cara:
* Menjumlahkan dua koordinat
* Membaginya dengan 2 menggunakan bc
dan menyimpan perhitungan di dalam file posisipusaka.txt
step terakhir menampilkan hasil koordinat pusat ke terminal.

```c
input="titik-penting.txt"
output="posisipusaka.txt"

p1=$(head -n 1 $input)
p2=$(tail -n 1 $input)

lat1=$(echo $p1 | cut -d',' -f3)
lon1=$(echo $p1 | cut -d',' -f4)

lat2=$(echo $p2 | cut -d',' -f3)
lon2=$(echo $p2 | cut -d',' -f4)

lat_mid=$(echo "($lat1 + $lat2)/2" | bc -l)
lon_mid=$(echo "($lon1 + $lon2)/2" | bc -l)

echo "$lat_mid,$lon_mid" > $output

echo "Koordinat pusat:"
cat $output
```

Output titik-penting.txt
<img width="701" height="134" alt="Tangkapan Layar 2026-03-29 pukul 18 44 42" src="https://github.com/user-attachments/assets/abd68f75-ccc8-4cb8-999d-472279bcecd1" />

output posisipusaka.txt
<img width="530" height="54" alt="Tangkapan Layar 2026-03-29 pukul 18 45 32" src="https://github.com/user-attachments/assets/9bfe75d0-7aa4-4396-9d7f-5980a5468a44" />

**Kendala**

Kesalahan Input


