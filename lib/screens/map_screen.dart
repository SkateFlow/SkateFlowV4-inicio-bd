import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  final Set<Marker> _markers = {};
  
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadSkateparks();
  }
  
  Future<void> _getCurrentLocation() async {
    // Verificar permissão de localização
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    
    // Obter localização atual
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
    
    // Mover câmera para a localização atual
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        14,
      ),
    );
  }
  
  void _loadSkateparks() {
    final skateparks = [
      {
        'id': '1',
        'name': 'Skate City',
        'type': 'Street',
        'address': 'Centro da cidade',
        'hours': '8h às 22h',
        'rating': 4.5,
        'features': ['Bowl', 'Street', 'Half-pipe', 'Corrimão'],
        'lat': -23.5505,
        'lng': -46.6333,
      },
      {
        'id': '2',
        'name': 'Rajas Skatepark',
        'type': 'Bowl',
        'address': 'Zona Sul',
        'hours': '6h às 20h',
        'rating': 4.8,
        'features': ['Bowl', 'Mini Ramp'],
        'lat': -23.5729,
        'lng': -46.6412,
      },
      {
        'id': '3',
        'name': 'Quadespra',
        'type': 'Plaza',
        'address': 'Zona Norte',
        'hours': '7h às 18h',
        'rating': 4.2,
        'features': ['Plaza', 'Street', 'Escadas'],
        'lat': -23.5200,
        'lng': -46.6094,
      },
    ];
    
    setState(() {
      _markers.clear();
      for (final park in skateparks) {
        _markers.add(
          Marker(
            markerId: MarkerId(park['id'] as String),
            position: LatLng(
              park['lat'] as double,
              park['lng'] as double,
            ),
            infoWindow: InfoWindow(
              title: park['name'] as String,
              snippet: '${park['type']} • ${park['rating']} ⭐',
            ),
            onTap: () => _showParkDetails(park),
          ),
        );
      }
    });
  }

  void _showParkDetails(Map<String, dynamic> park) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          height: 350,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      park['name'] as String,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      park['type'] as String,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: isDark ? Colors.white70 : Colors.black54),
                  const SizedBox(width: 4),
                  Text(
                    park['address'] as String,
                    style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: isDark ? Colors.white70 : Colors.black54),
                  const SizedBox(width: 4),
                  Text(
                    'Aberto das ${park['hours']}',
                    style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    '${park['rating']} estrelas',
                    style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Estruturas',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: (park['features'] as List<String>)
                    .map((feature) => Chip(
                          label: Text(feature, style: const TextStyle(color: Colors.black)),
                          backgroundColor: Colors.grey.shade200,
                        ))
                    .toList(),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showFullParkDetails(park);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? Colors.white : Colors.black,
                        foregroundColor: isDark ? Colors.black : Colors.white,
                      ),
                      child: const Text('Ver Mais'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Como Chegar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFullParkDetails(Map<String, dynamic> park) {
    final parkData = {
      'name': park['name'],
      'type': park['type'],
      'distance': '1.2 km',
      'rating': park['rating'],
      'address': park['address'],
      'hours': park['hours'],
      'features': park['features'],
      'description': park['name'] == 'Skate City'
          ? 'Pista completa no centro da cidade com estruturas variadas para todos os níveis.'
          : park['name'] == 'Rajas Skatepark'
              ? 'Bowl clássico perfeito para manobras aéreas e transições suaves.'
              : 'Plaza urbana com obstáculos técnicos para street skating avançado.',
      'images': park['name'] == 'Skate City'
          ? ['assets/images/skateparks/SkateCity.png', 'assets/images/skateparks/SkateCity2.png']
          : park['name'] == 'Rajas Skatepark'
              ? ['assets/images/skateparks/Rajas1.png', 'assets/images/skateparks/Rajas2.png']
              : ['assets/images/skateparks/image2.png', 'assets/images/skateparks/image9.png'],
    };

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        minChildSize: 0.7,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: _buildModalImageCarousel(parkData['images'] as List<String>),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            parkData['name'] as String,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            parkData['type'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      parkData['description'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white70
                            : Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildInfoRow(Icons.location_on, parkData['address'] as String),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.access_time, 'Aberto das ${parkData['hours']}'),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.directions, parkData['distance'] as String),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '${parkData['rating']} estrelas',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Estruturas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (parkData['features'] as List<String>)
                          .map(
                            (feature) => Chip(
                              label: Text(
                                feature,
                                style: TextStyle(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.black
                                      : Colors.black,
                                ),
                              ),
                              backgroundColor: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade200,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Como Chegar'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Favoritar'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModalImageCarousel(List<String> images) {
    return StatefulBuilder(
      builder: (context, setModalState) {
        int currentModalPage = 0;
        PageController modalController = PageController();

        return Stack(
          children: [
            PageView.builder(
              controller: modalController,
              itemCount: images.length,
              onPageChanged: (pageIndex) {
                setModalState(() {
                  currentModalPage = pageIndex;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.skateboarding,
                            size: 60,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Imagem não encontrada',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            if (images.length > 1)
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: images.asMap().entries.map((entry) {
                    return Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentModalPage == entry.key
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.4),
                        border: Border.all(
                          color: Colors.black.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            if (images.length > 1)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${currentModalPage + 1}/${images.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mapa',
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: const Color(0xFF2C2C2C),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: _currentPosition == null
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.white 
                    : Colors.black,
              ),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                ),
                zoom: 14,
              ),
              myLocationEnabled: true,
              markers: _markers,
              onMapCreated: (controller) {
                _mapController = controller;
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}