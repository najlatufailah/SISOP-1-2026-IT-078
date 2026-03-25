BEGIN {
    FS=","
    mode = ARGV[2]   # ambil a/b/c/d/e
    ARGV[2] = ""     # hapus biar gak dianggap file
}

# skip header
NR==1 { next }

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

END {
    if (mode=="a") {
        print "Jumlah seluruh penumpang KANJ adalah " count " orang"
    }
    else if (mode=="b") {
        for (c in carriage) total_carriage++
        print "Jumlah gerbong penumpang KANJ adalah " total_carriage
    }
    else if (mode=="c") {
        print oldest " adalah penumpang kereta tertua dengan usia " max_age " tahun"
    }
    else if (mode=="d") {
        avg = int(total_age / total)
        print "Rata-rata usia penumpang adalah " avg " tahun"
    }
    else if (mode=="e") {
        print "Jumlah penumpang business class adalah " business " orang"
    }
    else {
        print "Soal tidak dikenali. Gunakan a, b, c, d, atau e."
    }
}
