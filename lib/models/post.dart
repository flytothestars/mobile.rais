class Post {
  int? id;
  String? address;
  String? lat;
  String? lng;
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
        id: json['post']['id'],
        address: json['post']['address'],
        lat: json['post']['lat'],
        lng: json['post']['lng'],
        qr_code: json['post']['qr_code'],
        slot: json['post']['slot'],
        freeslot: json['post']['freeslot']);
  }
}
