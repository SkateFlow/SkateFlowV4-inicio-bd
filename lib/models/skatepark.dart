class Skatepark {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final List<String> features;
  final String imageUrl;
  final double rating;
  final String openingHours;

  Skatepark({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.features,
    required this.imageUrl,
    required this.rating,
    required this.openingHours,
  });

  factory Skatepark.fromMap(Map<String, dynamic> map) {
    return Skatepark(
      id: map['id'],
      name: map['name'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      features: List<String>.from(map['features'] ?? []),
      imageUrl: map['imageUrl'] ?? '',
      rating: map['rating'] ?? 0.0,
      openingHours: map['openingHours'] ?? '',
    );
  }
}
