class Place {
  final String city;
  final double lat;
  final double long;

  Place({required this.city, required this.lat, required this.long});
  
  static Place fromJson(Map<String, dynamic> json)=> Place(
  city: json['City'], 
  lat: json['lat'], 
  long: json['long']
  );
}

Place fromJson(Map<String, dynamic> json)=> Place(
  city: json['City'], 
  lat: json['lat'], 
  long: json['long']
  );