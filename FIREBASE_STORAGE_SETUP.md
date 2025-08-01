# Configuração do Firebase Storage para Imagens

## 1. Configuração Inicial

### Adicionar dependências no pubspec.yaml:
```yaml
dependencies:
  firebase_core: ^2.15.1
  firebase_storage: ^11.2.6
  image_picker: ^1.0.4
```

### Configurar Firebase no main.dart:
```dart
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SkateApp());
}
```

## 2. Estrutura de Pastas no Firebase Storage

```
/skateparks/
  ├── images/
  │   ├── skatepark_central.jpg
  │   ├── bowl_liberdade.jpg
  │   ├── pista_ibirapuera.jpg
  │   └── skate_plaza_vila_madalena.jpg
  └── thumbnails/
      ├── skatepark_central_thumb.jpg
      ├── bowl_liberdade_thumb.jpg
      ├── pista_ibirapuera_thumb.jpg
      └── skate_plaza_vila_madalena_thumb.jpg
```

## 3. Serviço de Upload de Imagens

```dart
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUploadService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String?> uploadParkImage(File imageFile, String parkId) async {
    try {
      final ref = _storage.ref().child('skateparks/images/$parkId.jpg');
      final uploadTask = ref.putFile(imageFile);
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Erro ao fazer upload: $e');
      return null;
    }
  }

  static Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
```

## 4. Widget para Exibir Imagens do Firebase

```dart
import 'package:cached_network_image/cached_network_image.dart';

Widget buildFirebaseImage(String imageUrl, String parkName, String parkType) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: BoxFit.cover,
    placeholder: (context, url) => Container(
      color: Colors.grey.shade300,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ),
    errorWidget: (context, url, error) {
      return ImageGenerator.generateParkImage(parkName, parkType);
    },
  );
}
```

## 5. Atualizar Modelo Skatepark

```dart
class Skatepark {
  final String id;
  final String name;
  final String imageUrl; // URL do Firebase Storage
  final String thumbnailUrl; // URL da miniatura
  // ... outros campos

  Skatepark({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.thumbnailUrl,
    // ... outros campos
  });
}
```

## 6. Regras de Segurança do Firebase Storage

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /skateparks/{allPaths=**} {
      allow read: if true; // Permitir leitura pública
      allow write: if request.auth != null; // Apenas usuários autenticados podem escrever
    }
  }
}
```

## 7. Otimizações

- Use `cached_network_image` para cache automático
- Crie thumbnails para carregamento mais rápido
- Implemente lazy loading para listas grandes
- Configure compressão de imagens antes do upload

## 8. Migração dos Assets Locais

1. Faça upload das imagens para o Firebase Storage
2. Atualize os dados das pistas com as URLs do Firebase
3. Remova os assets locais do projeto
4. Atualize o código para usar as URLs do Firebase