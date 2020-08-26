class Province {
    int id;
    String nama;

    Province({
        this.id,
        this.nama
    });

    factory Province.fromJson(Map<String, dynamic> json) {
        return Province(
            id: json['id'],
            nama: json['nama']
        );
    }
}