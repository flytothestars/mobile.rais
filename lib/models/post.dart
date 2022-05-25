class Post {
  int? id;
  String? address;
  double? lat;
  double? lng;
  String? qr_code;
  int? slot;
  int? freeslot;

  Post(
      {this.id,
      this.address,
      this.lat,
      this.lng,
      this.qr_code,
      this.slot,
      this.freeslot});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        address: json['address'],
        lat: json['lat'],
        lng: json['lng'],
        qr_code: json['qr_code'],
        slot: json['slot'],
        freeslot: json['freeslot']);
  }
}
