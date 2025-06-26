import 'package:flutter/material.dart';

class SkateparksScreen extends StatelessWidget {
  const SkateparksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final skateparks = [
      {
        'name': 'Skatepark Central',
        'type': 'Street',
        'distance': '1.2 km',
        'rating': 4.5,
        'address': 'Av. Paulista, 1000',
        'hours': '8h às 22h',
        'features': ['Bowl', 'Street', 'Half-pipe', 'Corrimão'],
        'description': 'Pista completa no centro da cidade com estruturas variadas para todos os níveis.',
      },
      {
        'name': 'Bowl da Liberdade',
        'type': 'Bowl',
        'distance': '2.5 km',
        'rating': 4.8,
        'address': 'R. da Liberdade, 500',
        'hours': '6h às 20h',
        'features': ['Bowl', 'Mini Ramp'],
        'description': 'Bowl clássico perfeito para manobras aéreas e transições suaves.',
      },
      {
        'name': 'Pista do Ibirapuera',
        'type': 'Vert',
        'distance': '3.1 km',
        'rating': 4.2,
        'address': 'Parque Ibirapuera',
        'hours': '7h às 18h',
        'features': ['Vert', 'Street', 'Escadas'],
        'description': 'Localizada no parque, ideal para sessões ao ar livre com vista incrível.',
      },
      {
        'name': 'Skate Plaza Vila Madalena',
        'type': 'Plaza',
        'distance': '4.0 km',
        'rating': 4.6,
        'address': 'Vila Madalena',
        'hours': '24h',
        'features': ['Plaza', 'Escadas', 'Corrimão', 'Gaps'],
        'description': 'Plaza urbana com obstáculos técnicos para street skating avançado.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pistas'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: skateparks.length,
        itemBuilder: (context, index) {
          final park = skateparks[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => _showParkDetails(context, park),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            park['name'] as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            park['type'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      park['description'] as String,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          park['distance'] as String,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          park['rating'].toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showParkDetails(BuildContext context, Map<String, dynamic> park) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        park['name'] as String,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
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
                        park['type'] as String,
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
                  park['description'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoRow(Icons.location_on, park['address'] as String),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.access_time, 'Aberto das ${park['hours']}'),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.directions, park['distance'] as String),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '${park['rating']} estrelas',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Estruturas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (park['features'] as List<String>).map((feature) => 
                    Chip(
                      label: Text(feature),
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ).toList(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}