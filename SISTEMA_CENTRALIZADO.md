# Sistema Centralizado de Dados - SkateFlow

## Estrutura Implementada

### 1. Modelo de Dados (`lib/models/skatepark.dart`)
- Classe `Skatepark` com todos os campos necessários
- Métodos `toJson()` e `fromJson()` para serialização
- Método `copyWith()` para atualizações imutáveis

### 2. Serviço Centralizado (`lib/services/skatepark_service.dart`)
- Singleton que gerencia todos os dados das pistas
- Sistema de listeners para notificar mudanças
- Métodos preparados para integração com API/BD

### 3. Integração nas Telas
- **Home Screen**: Usa dados centralizados
- **Map Screen**: Usa dados centralizados  
- **Skateparks Screen**: Usa dados centralizados

## Como Funciona

### Atualizações Automáticas
Quando você alterar dados de uma pista:

```dart
// Exemplo de atualização
final updatedPark = park.copyWith(name: 'Novo Nome');
await SkateparkService().updateSkatepark(updatedPark);
```

Todas as telas serão automaticamente atualizadas!

### Preparação para Banco de Dados

O serviço já está preparado para integração:

```dart
// Futuro: integração com API
Future<void> updateSkatepark(Skatepark updatedPark) async {
  // Chamada para API
  final response = await http.put('/api/skateparks/${updatedPark.id}', 
    body: updatedPark.toJson());
  
  if (response.statusCode == 200) {
    // Atualizar dados locais
    final index = _skateparks.indexWhere((park) => park.id == updatedPark.id);
    if (index != -1) {
      _skateparks[index] = updatedPark;
      _notifyListeners(); // Atualiza todas as telas
    }
  }
}
```

### Vantagens

1. **Consistência**: Dados sempre sincronizados entre telas
2. **Facilidade**: Uma mudança atualiza tudo automaticamente  
3. **Preparado para BD**: Estrutura pronta para integração
4. **Escalável**: Fácil adicionar novas funcionalidades

### Próximos Passos

1. Integrar com API REST
2. Adicionar cache local
3. Implementar sincronização offline
4. Adicionar validações de dados