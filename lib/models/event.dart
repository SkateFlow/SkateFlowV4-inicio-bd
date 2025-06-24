class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String imageUrl;
  final String organizerId;
  final List<String> participants;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.organizerId,
    required this.participants,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'] is DateTime 
          ? map['date'] 
          : DateTime.parse(map['date'].toString()),
      location: map['location'],
      imageUrl: map['imageUrl'] ?? '',
      organizerId: map['organizerId'],
      participants: List<String>.from(map['participants'] ?? []),
    );
  }
}
