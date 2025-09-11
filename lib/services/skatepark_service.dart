import '../models/skatepark.dart';

class SkateparkService {
  static final SkateparkService _instance = SkateparkService._internal();
  factory SkateparkService() => _instance;
  SkateparkService._internal();

  // Lista de pistas (futuramente será substituída por chamadas ao banco de dados)
  final List<Skatepark> _skateparks = [
    Skatepark(
      id: '1',
      name: 'Skate City',
      type: 'Street',
      lat: -23.5505,
      lng: -46.6333,
      rating: 4.5,
      address: 'Rua Jaraguá, 627 - Bom Retiro, SP',
      hours: '8h às 22h',
      features: ['Bowl', 'Street', 'Half-pipe', 'Corrimão'],
      description: 'Pista completa no centro da cidade com estruturas variadas para todos os níveis.',
      images: [
        'assets/images/skateparks/SkateCity.png',
        'assets/images/skateparks/SkateCity2.png'
      ],
    ),
    Skatepark(
      id: '2',
      name: 'AAAAAA FECHADA',
      type: 'Bowl',
      lat: -23.5729,
      lng: -46.6412,
      rating: 4.8,
      address: 'Zona Sul',
      hours: '6h às 20h',
      features: ['Bowl', 'Mini Ramp'],
      description: 'Bowl clássico perfeito para manobras aéreas e transições suaves.',
      images: [
        'assets/images/skateparks/Rajas1.png',
        'assets/images/skateparks/Rajas2.png'
      ],
    ),
    Skatepark(
      id: '3',
      name: 'Quadespra',
      type: 'Plaza',
      lat: -23.520000,
      lng: -46.609400,
      rating: 4.2,
      address: 'Rua Lacônia, 266 - Vila Alexandria, São Paulo - SP',
      hours: '7h às 18h',
      features: ['Plaza', 'Street', 'Escadas'],
      description: 'Plaza urbana com obstáculos técnicos para street skating avançado.',
      images: [
        'assets/images/skateparks/image2.png',
        'assets/images/skateparks/image9.png'
      ],
    ),
  ];

  // Callbacks para notificar mudanças
  final List<Function()> _listeners = [];

  // Métodos para gerenciar listeners
  void addListener(Function() listener) {
    _listeners.add(listener);
  }

  void removeListener(Function() listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  // Métodos para acessar dados
  List<Skatepark> getAllSkateparks() {
    return List.from(_skateparks);
  }

  Skatepark? getSkateparkById(String id) {
    try {
      return _skateparks.firstWhere((park) => park.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Skatepark> getSkateparksByType(String type) {
    if (type == 'Todos') return getAllSkateparks();
    return _skateparks.where((park) => park.type == type).toList();
  }

  List<Skatepark> getSkateparksByRating(double minRating) {
    if (minRating == 0.0) return getAllSkateparks();
    return _skateparks.where((park) => park.rating >= minRating).toList();
  }

  // Métodos para modificar dados (futuramente integrados com API/BD)
  Future<void> updateSkatepark(Skatepark updatedPark) async {
    // Simula chamada para API/BD
    await Future.delayed(const Duration(milliseconds: 500));
    
    final index = _skateparks.indexWhere((park) => park.id == updatedPark.id);
    if (index != -1) {
      _skateparks[index] = updatedPark;
      _notifyListeners();
    }
  }

  Future<void> addSkatepark(Skatepark newPark) async {
    // Simula chamada para API/BD
    await Future.delayed(const Duration(milliseconds: 500));
    
    _skateparks.add(newPark);
    _notifyListeners();
  }

  Future<void> deleteSkatepark(String id) async {
    // Simula chamada para API/BD
    await Future.delayed(const Duration(milliseconds: 500));
    
    _skateparks.removeWhere((park) => park.id == id);
    _notifyListeners();
  }

  // Método para sincronizar com servidor (futuro)
  Future<void> syncWithServer() async {
    // Aqui será implementada a sincronização com o servidor
    // Por enquanto, apenas simula uma operação
    await Future.delayed(const Duration(seconds: 2));
  }

  // Método para buscar dados do servidor (futuro)
  Future<void> fetchFromServer() async {
    // Aqui será implementada a busca de dados do servidor
    // Por enquanto, apenas simula uma operação
    await Future.delayed(const Duration(seconds: 1));
    _notifyListeners();
  }
}