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







