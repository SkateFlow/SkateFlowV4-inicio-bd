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
    // Dados de exemplo - seriam carregados do Firebase
    final skateparks = [
      {
        'id': '1',
        'name': 'Skatepark Central',
        'lat': -23.550520,
        'lng': -46.633308,
      },
      {
        'id': '2',
        'name': 'Bowl da Liberdade',
        'lat': -23.555550,
        'lng': -46.639999,
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
              snippet: 'Toque para mais detalhes',
            ),
            onTap: () => _showParkDetails(park['id'] as String),
          ),
        );
      }
    });
  }

  void _showParkDetails(String parkId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Skatepark Central',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: isDark ? Colors.white70 : Colors.black54),
                  const SizedBox(width: 4),
                  Text(
                    'Av. Paulista, 1000',
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
                    'Aberto das 8h às 22h',
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
                children: [
                  Chip(
                    label: Text('Bowl', style: TextStyle(color: Colors.black)),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  Chip(
                    label: Text('Street', style: TextStyle(color: Colors.black)),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  Chip(
                    label: Text('Half-pipe', style: TextStyle(color: Colors.black)),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  Chip(
                    label: Text('Corrimão', style: TextStyle(color: Colors.black)),
                    backgroundColor: Colors.grey.shade200,
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? Colors.white : Colors.black,
                    foregroundColor: isDark ? Colors.black : Colors.white,
                  ),
                  child: Text('Como Chegar'),
                ),
              ),
            ],
          ),
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00294F), Color(0xFF001426), Color(0xFF010A12), Color(0xFF00294F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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