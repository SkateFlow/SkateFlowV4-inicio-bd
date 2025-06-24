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
              snippet: 'Toque para detalhes',
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
      builder: (context) => Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Skatepark Central',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.location_on, size: 16),
                SizedBox(width: 4),
                Text('Av. Paulista, 1000'),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.access_time, size: 16),
                SizedBox(width: 4),
                Text('Aberto das 8h às 22h'),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Estruturas',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('Bowl')),
                Chip(label: Text('Street')),
                Chip(label: Text('Half-pipe')),
                Chip(label: Text('Corrimão')),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Ver Detalhes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pistas Próximas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
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