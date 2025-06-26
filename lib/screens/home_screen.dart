import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadNearbyParks();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    
    if (permission != LocationPermission.denied) {
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
    }
  }

  void _loadNearbyParks() {
    final parks = [
      {'name': 'Skatepark Central', 'lat': -23.550520, 'lng': -46.633308},
      {'name': 'Bowl da Liberdade', 'lat': -23.555550, 'lng': -46.639999},
    ];

    setState(() {
      _markers.clear();
      for (final park in parks) {
        _markers.add(
          Marker(
            markerId: MarkerId(park['name'] as String),
            position: LatLng(park['lat'] as double, park['lng'] as double),
            infoWindow: InfoWindow(title: park['name'] as String),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final events = [
      {'title': 'Campeonato Municipal', 'date': '15/06', 'location': 'Skatepark Central', 'participants': '45'},
      {'title': 'Workshop de Manobras', 'date': '22/06', 'location': 'Bowl da Liberdade', 'participants': '23'},
      {'title': 'Sessão Noturna', 'date': '28/06', 'location': 'Pista do Ibirapuera', 'participants': '67'},
    ];

    final nearbyParks = [
      {'name': 'Skatepark Central', 'distance': '1.2 km', 'rating': 4.5, 'type': 'Street'},
      {'name': 'Bowl da Liberdade', 'distance': '2.5 km', 'rating': 4.8, 'type': 'Bowl'},
      {'name': 'Pista do Ibirapuera', 'distance': '3.1 km', 'rating': 4.2, 'type': 'Vert'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('SkateFlow'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Olá, Skatista!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Encontre as melhores pistas e eventos',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Eventos em Destaque
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Eventos em Destaque',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Ver todos'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Container(
                    width: 300,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.grey.shade800],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                event['title'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${event['participants']} pessoas',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.white70, size: 16),
                            const SizedBox(width: 6),
                            Text(event['date'] as String, style: const TextStyle(color: Colors.white70)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.white70, size: 16),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                event['location'] as String,
                                style: const TextStyle(color: Colors.white70),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Pistas Próximas
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pistas Próximas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Ver todas'),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: nearbyParks.length,
              itemBuilder: (context, index) {
                final park = nearbyParks[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(Icons.skateboarding, color: Colors.white, size: 24),
                    ),
                    title: Text(
                      park['name'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                park['type'] as String,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.location_on, size: 14, color: Colors.grey),
                            const SizedBox(width: 2),
                            Text(park['distance'] as String, style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              park['rating'].toString(),
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                );
              },
            ),
            
            // Mapa das Pistas
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Mapa das Pistas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _currentPosition == null
                    ? const Center(child: CircularProgressIndicator())
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                          zoom: 12,
                        ),
                        markers: _markers,
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        mapToolbarEnabled: false,
                      ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}