# OpenStreetMap Migration

Este projeto foi migrado do Google Maps para OpenStreetMap usando Leaflet.

## Mudanças Realizadas

### 1. Dependências (pubspec.yaml)
- **Removido**: `google_maps_flutter: ^2.5.0`
- **Adicionado**: 
  - `flutter_map: ^7.0.2`
  - `latlong2: ^0.9.1`

### 2. Código Flutter
- **map_screen.dart**: Migrado de GoogleMap para FlutterMap
- **home_screen.dart**: Migrado de GoogleMap para FlutterMap

### 3. Configurações Android
- **Removido**: Google Maps API key do AndroidManifest.xml
- **Adicionado**: Permissão de INTERNET para carregar tiles do OpenStreetMap

### 4. Configurações Web
- **Removido**: Script do Google Maps
- **Adicionado**: CSS e JS do Leaflet

## Funcionalidades Implementadas

✅ Mapa interativo com OpenStreetMap  
✅ Localização do usuário  
✅ Marcadores para skateparks  
✅ Controles de zoom  
✅ Navegação por toque  

## Vantagens da Migração

- **Gratuito**: Sem necessidade de API key ou cobrança
- **Open Source**: Dados abertos e comunidade ativa
- **Performance**: Tiles leves e rápidos
- **Privacidade**: Sem rastreamento do Google

## Como Usar

O mapa funciona exatamente como antes, mas agora usa dados do OpenStreetMap:

```dart
FlutterMap(
  options: MapOptions(
    initialCenter: LatLng(latitude, longitude),
    initialZoom: 14,
  ),
  children: [
    TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.skateflow',
    ),
    MarkerLayer(markers: markers),
  ],
)
```

## Código JavaScript Equivalente (Web)

Para referência, o código JavaScript equivalente seria:

```javascript
var map = L.map('map').fitWorld();

L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: '© OpenStreetMap'
}).addTo(map);

map.locate({setView: true, maxZoom: 16});

function onLocationFound(e) {
    var radius = e.accuracy;
    L.marker(e.latlng).addTo(map)
        .bindPopup("You are within " + radius + " meters from this point").openPopup();
    L.circle(e.latlng, radius).addTo(map);
}

map.on('locationfound', onLocationFound);

function onLocationError(e) {
    alert(e.message);
}

map.on('locationerror', onLocationError);
```