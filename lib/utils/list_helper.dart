class ListHelper {
  List<String> provinsi = ["Sumatera Selatan"];

  List<String> kabupaten = [
    "Kab. Ogan Komering Ulu (Ibukota Baturaja)",
    "Kab. Ogan Komering UluTimur (Ibukota Martapura)",
    "Kab. Ogan Komering UluSelatan(Ibukota Muara Dua)",
    "Kab. Ogan Komering Ilir (Ibukota Kayu Agung)",
    "Kab. Muara Enim (Ibukota Muara Enim)",
    "Kab. Lahat (Ibukota Lahat)",
    "Kab. Musi Rawas (Ibukota Muara Beliti)",
    "Kab. Musi Banyuasin (Ibukota Sekayu)",
    "Kab. Banyuasin (Ibukota Pangkalan Balai)",
    "Kab. Empat Lawang (Ibukota Tebingtinggi)",
    "Kota Ogan Ilir (Ibukota Indralaya)",
    "Kota Palembang (Ibukota Palembang)",
    "Kota Pagar Alam (Ibukota Pagar Alam)",
    "Kota Lubuk Linggau (Ibukota Lubuk Linggau)",
    "Kota Prabumulih (Ibukota Prabumulih)",
    "Kabupaten Panukal Abab lematang Ilir  (Ibukota Talang Ubi)",
    "Kabupaten Musi Rawas Utara (Ibukota Muara Rupit)"
  ];

  List<String> kecamatan = [
    "Air Sugihan.",
    "Cengal.",
    "Jejawi.",
    "Kayu Agung.",
    "Lempuing.",
    "Lempuing Jaya.",
    "Mesuji.",
    "Mesuji Makmur.",
    "Mesuji Raya",
    "Pampangan",
    "Pangkalan Lampam",
    "Pedamaran",
    "Pedamaran Timur",
    "Sirah Pulau Padang",
    "Sungai Menang",
    "Tanjung Lubuk",
    "Teluk Gelam",
    "Tulung Selapan",
    "Lainnya"
  ];

  List<String> keluarahan = [
    "Bandar Jaya",
    "Banyu Biru",
    "Jadimulya",
    "Kertamukti",
    "Margatani",
    "Mukti Jaya",
    "Negeri Sakti",
    "Nusakarta",
    "Nusantara",
    "Pangkalan Damai",
    "Pangkalan Sakti",
    "Rantau Karya",
    "Rengas Abang",
    "Simpang Heran",
    "Srijaya Baru",
    "Sukamulya",
    "Sungai Batang",
    "Tirta Mulya",
    "Adil Makmur",
    "Balam Jeruju",
    "Cengal",
    "Kebun Angkik",
    "Kebun Cabe",
    "Kuala Sungai Jeruju",
    "Kuala Sungai Pasir",
    "Lebak Beriang",
    "Lembah Sunyi",
    "Pantai Harapan",
    "Parit Raya",
    "Pelimbangan",
    "Rimba Nanjung",
    "Sukaramai Makmur",
    "Sungai Jeruju",
    "Sungai Ketupak",
    "Sungai Lumpur",
    "Sungai Pasir",
    "Sungai Somor",
    "Talang Rimba",
    "Tanjung Harapan",
    "Tulung Udi'an",
    "Ulak Kedondong",
    "Air Itam",
    "Batun Baru",
    "Bubusan",
    "Danau Ceper",
    "Jejawi",
    "Karang Agung",
    "Lingkis",
    "Lubuk Ketepeng",
    "Muara Batun",
    "Padang Bulan",
    "Pedu",
    "Pematang Kijang",
    "Simpang Empat",
    "Sukadarma",
    "Talang Cempedak",
    "Tanjung Ali",
    "Tanjung Aur",
    "Terusan Jawa",
    "Ulak Tembaga",
    "Anyar",
    "Arisan Buntal",
    "Banding Anyar",
    "Buluh Cawang",
    "Celikah",
    "Kelurahan Cinta Raja",
    "Kelurahan Jua-Jua",
    "Kelurahan Kayuagung",
    "Kelurahan Kedaton",
    "Kelurahan Mangun Jaya",
    "Kelurahan Paku",
    "Kelurahan Perigi",
    "Kelurahan Sidakersa",
    "Kelurahan Sukadana",
    "Kelurahan Tanjung Rancing",
    "Kelurahana Kutaraya",
    "Kijang Ulu",
    "Lubuk Dalam",
    "Muara Baru",
    "Serigeni",
    "Serigeni Baru",
    "Tanjung Lubuk",
    "Tanjung Menang",
    "Tanjung Serang",
    "Teloko",
    "Bumiagung",
    "Bumiarjo",
    "Bumiarjo Makmur",
    "Cahaya Bumi",
    "Cahaya Bumi Tiyuh",
    "Cahaya Makmur",
    "Cahya Bakti",
    "Cahya Maju",
    "Cahya Tani",
    "Dabuk Mulyo",
    "Dabuk Rejo",
    "Kepayang",
    "Kepayang Asri",
    "Margo Agung",
    "Mekar Jaya",
    "Rejo Agung",
    "Sendang Agung",
    "Simpang Dabuk",
    "Sindang Sari",
    "Sukamulya",
    "Sumber Agung",
    "Sumber Makmur",
    "Sumber Mulya",
    "Tebing Suluh",
    "Tebing Suluh Asli",
    "Tebing Suluh Jaya",
    "Tugu Agung",
    "Tugu Jaya",
    "Tugu Jaya Satu",
    "Tugu Mulyo I",
    "Tugu Mulyo Induk",
    "Tugu Mulyo Makmur",
    "Tulung Harapan",
    "Lempuing Indah",
    "Lubuk Makmur",
    "Lubuk Seberuk",
    "Muara Burnai I",
    "Muara Burnai II",
    "Mukti Sari",
    "Purwo Asri",
    "Rantau Durian Asli",
    "Rantau Durian I",
    "Rantau Durian II",
    "Sukajaya",
    "Sukamaju",
    "Sungai Belida",
    "Tania Makmur",
    "Tanjung Sari I",
    "Tanjung Sari II",
    "Jaya Bhakti",
    "Kali Deras",
    "Karya Mukti",
    "Kembang Jajar",
    "Kota Baru",
    "Labuhan Jaya",
    "Makarti Mulya",
    "Margo Bhakti",
    "Margo Mulya",
    "Mekar wangi",
    "Pagar Dewa",
    "Pematang Jaya",
    "Pematang Kasih",
    "Pematang Panggang",
    "Sido Basuki",
    "Suka Mukti",
    "Sumber Deras",
    "Sungai Sodong",
    "Surya Adi",
    "Beringin Jaya",
    "Bhinakarsa",
    "Cahaya Makmur (persiapan)",
    "Cahaya Mas",
    "Cahaya Mulya",
    "Catur Tunggal",
    "Gading Sari",
    "Kampung Baru",
    "Karya Jaya",
    "Karya Usaha",
    "Mesuji Jaya",
    "Mukti Karya",
    "Pematang Bina Tani",
    "Pematang Jaya",
    "Pematang Sari",
    "Pematang Sukarama",
    "Pematang Sukatani",
    "Sidomakmur",
    "Sumber Mulya",
    "Suryakarta",
    "Tegal Sari",
    "Balian",
    "Balian Makmur",
    "Bumi Makmur",
    "Cipta Sari",
    "Dabuk Makmur",
    "Embacang",
    "Embacang Permai",
    "Gedung Rejo",
    "Kemang Indah",
    "Kerta Mukti",
    "Mataram Jaya",
    "Mulya Jaya",
    "Rotan Mulya",
    "Sedyo Mulyo",
    "Suka Sari",
    "Sumber Baru",
    "Sumbu Sari",
    "Bangsal",
    "Jermun",
    "Jungkal",
    "Kandis",
    "Keman",
    "Keman Baru",
    "Kuro",
    "Menggeris",
    "Pampangan",
    "Pulau Betung",
    "Pulau Layang",
    "Secondong",
    "Sepang",
    "Serdang",
    "Serimenang",
    "Srimulya",
    "Tanjung Kemang",
    "Tapus",
    "Ulak Depati",
    "Ulak Kemang",
    "Ulak Kemang Baru",
    "Ulak Pianggu",
    "Air Pedara",
    "Air Rumbai",
    "Bukit Batu",
    "Darat",
    "Deling",
    "Desa Pulauan",
    "Lebung Batang",
    "Lirik",
    "Pangkalan Lampam",
    "Perigi",
    "Rambai",
    "Rawa Tenam",
    "Riding",
    "Rimba Samak",
    "Sukadamai",
    "Sukaraja",
    "Sungai Bungin",
    "Sunggutan",
    "Talang Daya",
    "Burnai Timur",
    "Cinta Jaya",
    "Lebuh Rarak",
    "Menang Raya",
    "Pedamaran I",
    "Pedamaran II",
    "Pedamaran III",
    "Pedamaran IV",
    "Pedamaran V",
    "Pedamaran VI",
    "Pedamaran VI",
    "Serinanti",
    "Sukadamai",
    "Sukapulih",
    "Sukaraja",
    "Gading Raja",
    "Kayulabu",
    "Maribaya",
    "Pancawarna",
    "Pulau Geronggang",
    "Sumber Hidup",
    "Tanjung Makmur",
    "Awal Terusan",
    "Batu Ampar",
    "Batu Ampar Baru",
    "Belanti",
    "Berkat",
    "Bungin Tinggi",
    "Mangun Jaya",
    "Pantai",
    "Pematang Buluran",
    "Penyandingan",
    "Rawang Besar",
    "Rengas Pitu",
    "Serdang Menang",
    "Sirah Pulau Padang",
    "Sukaraja",
    "Tanjung Alai",
    "Terate",
    "Terusan Laut",
    "Terusan Menang",
    "Ulak Jermun",
    "Bumi Pratama Mandira",
    "Dewa Sibur",
    "Gading Jaya",
    "Gading Mas (SP5)",
    "Gajah Makmur",
    "Gajah Mati",
    "Gajah Mukti",
    "Gajah Mulya",
    "Harapan Jaya",
    "Karangsia",
    "Mesuji Karang Indah",
    "Nata  Sibur Jaya",
    "Pinang Indah",
    "Sidomulyo",
    "Sri Gading",
    "Sungai Ceper",
    "Sungai Menang",
    "Sungai Sibur",
    "Sungai Tepuk",
    "Talang Jaya",
    "Talang Makmur",
    "Tanjung Manjangan",
    "Atar Balam",
    "Bumiagung",
    "Jambu Ilir",
    "Jukdadak",
    "Kelurahan Tanjung Lubuk",
    "Kotabumi",
    "Pengarayan",
    "Pulau Gemantung",
    "Pulau Gemantung Darat",
    "Pulau Gemantung Ilir",
    "Pulau Gemantung Ulu",
    "Sritanjung",
    "Sukamulya",
    "Sukarami",
    "Tanjung Baru",
    "Tanjung Beringin",
    "Tanjung Harapan",
    "Tanjung Laga",
    "Tanjung Laut",
    "Tanjung Merindu",
    "Ulak Balam",
    "Ulak Kapal",
    "Benawa",
    "Bumi Harapan",
    "Cinta Marga",
    "Kuripan",
    "Muara Telang",
    "Mulya Guna",
    "Panca Tunggal Benawa",
    "Penyandingan",
    "Serapek",
    "Seriguna",
    "Sinar Harapan Mulya",
    "Sugih waras",
    "Talang Pangeran",
    "Ulak Ketapang",
    "Cambai",
    "Jerambah Rengas",
    "Kayuara",
    "Kuala Dua Belas",
    "Lebung Gajah",
    "Lebung Itam",
    "Penanggoan Duren",
    "Penyandingan",
    "Petaling",
    "Pulu Beruang",
    "Rantau Lurus",
    "Simpang Tiga",
    "Simpang Tiga Abadi",
    "Simpang Tiga Jaya",
    "Simpang Tiga Makmur",
    "Simpang Tiga Sakti",
    "Tanjung Batu",
    "Toman",
    "Tulung Selapan Ilir",
    "Tulung Selapan Timur",
    "Tulung Selapan Ulu",
    "Tulung Seluang",
    "Ujung Tanjung"
  ];

  List<String> pekerjaan = [
    "Belum/ Tidak Bekerja",
    "Mengurus Rumah Tangga",
    "Pelajar/ Mahasiswa",
    "Pensiunan",
    "Pewagai Negeri Sipil",
    "Tentara Nasional Indonesia",
    "Kepolisisan RI",
    "Perdagangan",
    "Petani/ Pekebun",
    "Peternak",
    "Nelayan/ Perikanan",
    "Industri",
    "Konstruksi",
    "Transportasi",
    "Karyawan Swasta",
    "Karyawan BUMN",
    "Karyawan BUMD",
    "Karyawan Honorer",
    "Buruh Harian Lepas",
    "Buruh Tani/ Perkebunan",
    "Buruh Nelayan/ Perikanan",
    "Buruh Peternakan",
    "Pembantu Rumah Tangga",
    "Tukang Cukur",
    "Tukang Listrik",
    "Tukang Batu",
    "Tukang Kayu",
    "Tukang Sol Sepatu",
    "Tukang Las/ Pandai Besi",
    "Tukang Jahit",
    "Tukang Gigi",
    "Penata Rias",
    "Penata Busana",
    "Penata Rambut",
    "Mekanik",
    "Seniman",
    "Tabib",
    "Paraji",
    "Perancang Busana",
    "Penterjemah",
    "Imam Masjid",
    "Pendeta",
    "Pastor",
    "Wartawan",
    "Ustadz/ Mubaligh",
    "Juru Masak",
    "Promotor Acara",
    "Anggota DPR-RI",
    "Anggota DPD",
    "Anggota BPK",
    "Presiden",
    "Wakil Presiden",
    "Anggota Mahkamah Konstitusi",
    "Anggota Kabinet/ Kementerian",
    "Duta Besar",
    "Gubernur",
    "Wakil Gubernur",
    "Bupati",
    "Wakil Bupati",
    "Walikota",
    "Wakil Walikota",
    "Anggota DPRD Provinsi",
    "Anggota DPRD Kabupaten/ Kota",
    "Dosen",
    "Guru",
    "Pilot",
    "Pengacara",
    "Notaris",
    "Arsitek",
    "Akuntan",
    "Konsultan",
    "Dokter",
    "Bidan",
    "Perawat",
    "Apoteker",
    "Psikiater/ Psikolog",
    "Penyiar Televisi",
    "Penyiar Radio",
    "Pelaut",
    "Peneliti",
    "Sopir",
    "Pialang",
    "Paranormal",
    "Pedagang",
    "Perangkat Desa",
    "Kepala Desa",
    "Biarawati",
    "Wiraswasta"
  ];

  List<String> fungsiBangunan = [
    "Rumah Tinggal",
    "Ruko (Rumah Toko)",
    "Tempat Usaha",
    "Rumah Ibadah",
    "Rumah & Warung",
    "Gudang",
    "Lainya"
  ];

  List<String> jumlahLantaiBangunan = [
    "1 Lantai",
    "1,5 Lantai",
    "2 Lantai",
    "2,5 Lantai",
    "3 Lantai",
    "Lebih dari 3 Lantai"
  ];

  List<String> jenisBangunan = ["Tidak Permanen", "Semi Permanen", "Permanen"];

  List<String> statusKepemilikanRumah = [
    "Milik Pribadi",
    "Sewa",
    "Numpang",
    "Lainnya"
  ];

  List<String> statusKepemilikanTanah = [
    "Milik Pribadi",
    "Sewa",
    "Numpang",
    "Lainnya"
  ];

  List<String> materialAtap = [
    "Terpal",
    "Daun",
    "Seng",
    "alkan/Sejenis",
    "Asbes",
    "Genteng",
    "Coran/Beton"
  ];

  List<String> kondisiAtap = [
    "Baik",
    "Rusak Ringan",
    "Rusak Sedang",
    "Rusak Berat"
  ];

  List<String> materialLantai = [
    "Tanah",
    "Kayu",
    "Beton/Coran",
    "Keramik atau Sejenis"
  ];

  List<String> kondisiLantai = [
    "Baik",
    "Rusak Ringan",
    "Rusak Sedang",
    "Rusak Berat"
  ];

  List<String> kondisiMaterial = [
    "Baik",
    "Rusak Ringan",
    "Rusak Sedang",
    "Rusak Berat"
  ];

  List<String> materialDinding = [
    "Terpal atau sejenis",
    "Kain",
    "Bambu/Anyaman",
    "Papan",
    "Triplek",
    "Batu Bata(Tanpa Cor)",
    "Dinding Cor / Plesteran",
    "Gypsum"
  ];

  List<String> kondisiRumah = [
    "Baik",
    "Rusak Ringan",
    "Rusak Sedang",
    "Rusak Berat"
  ];

  List<String> pondasi = ["Ada", "Tidak Ada"];

  List<String> sumberListrik = [
    "PLN",
    "PLTA (Pembangkit Listrik Tenaga Air)",
    "PLTU (Pembangkit Listrik Tenaga Uap)",
    "Nyambung Tetangga",
    "Genset",
    "Lampu Minyak/Sejenis"
  ];

  List<String> sumberAir = [
    "Sungai",
    "Danau/Kolam",
    "Air Gunung",
    "Sumur Gali",
    "Sumur Bor",
    "PDAM",
    "PAM / SIMAS"
  ];

  List<String> sanitasi = [
    "Septitank",
    "Sungai",
    "Galian Tanah",
    "Drainase",
    "Kolam/Danau",
    "sungai/abs"
  ];

  List<String> persampahan = [
    "Di Buang Ke sungai",
    "Di Bakar",
    "Di Kubur",
    "Di Buang ke TPS/TPA",
    "Di buang Ke Hutan/Semak"
  ];

  List<String> jenisPermukaan = [
    "Aspal",
    "Perkerasan Rigid / Beton",
    "Telford / Kerikil",
    "Tanah",
    "Jenis Lainnya"
  ];

  List<String> kondisiJalan = [
    "Baik (M)",
    "Sedang (M)",
    "Rusak Ringan (M)",
    "Rusak Berat (M)"
  ];

  List<String> memilikiSaluran = ["Ada", "Tidak Ada"];

  List<String> jikaAdaSaluran = [
    "Saluran Kanan Kiri",
    "Saluran Kanan Saja",
    "Saluran Kiri Saja"
  ];

  List<String> jenisSaluran = ["Terbuka", "Tertutup"];

  List<String> kondisiSaluran = ["Bersih", "Tertutup / Tersumbat", "Erosi"];

  List<String> jenisSaluranDrainase = ["Permanen / Pasangan","Tidak Permanen"];
  List<String> jenisKonstruksi = ["Cor Beton,","Cor Batu Kali,","Pasangan Bata","Tanah","Lainya"];
  List<String> kondisiKonstruksi = ["Baik","Rusak Ringan","Rusak Sedang","Rusak Berat"];
  List<String> jenisSaluranAtas = ["Terbuka","Tertutup"];
  List<String> kondisiAliranDrainase = ["Mengalir","Tertutup / Tersumbat","Erosi"];

  //helper sanitasi dropdown
  List<String> fasilitasSanitasi = [
    "WC Milik Sendiri",
    "WC Umum",
    "Sungai",
    "Kolam",
    "Cangkul Tanah"
  ];

  List<String> bangunanAtas = [
    "Jamban Duduk",
    "Jamban Leher Angsa",
    "Jamban Cemplung",
    "Jamban Plengsengan",
    "Jamban Cangkul"
  ];

  List<String> bangunanBawah = [
    "Tengki Septik (Septitank)",
    "Lubang Tanah",
    "Kolam",
    "Pipa (Mengalir ke Sungai / langsung ke tanah)"
  ];

  List<String> pembuanganAirLimbahRt = [
    "Drainase",
    "Kolam",
    "Sungai",
    "Sekitar Rumah"
  ];

  List<String> pembuanganSampahRt = [
    "Tempat Pembuangan Sementara",
    "Diangkut Mobil Sampah",
    "Dibakar",
    "Dibuang ke Sungai"
  ];

}
