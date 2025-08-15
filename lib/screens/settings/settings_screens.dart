import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: 'Carlos Silva');
  final _bioController = TextEditingController(text: 'Skatista há 5 anos. Especialista em manobras de street.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Salvar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bioController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePhotoScreen extends StatelessWidget {
  const ChangePhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar Foto'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Funcionalidade em desenvolvimento', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacidade'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Configurações de privacidade', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Idioma'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Seleção de idioma', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Configurações de notificações', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class SoundScreen extends StatelessWidget {
  const SoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Som e Vibração'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Configurações de som', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar Senha'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Alterar senha', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class ManageAccountScreen extends StatelessWidget {
  const ManageAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Conta'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Gerenciar conta', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excluir Conta'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Excluir conta', style: TextStyle(color: Colors.red)),
      ),
    );
  }
}

class GpsPermissionsScreen extends StatelessWidget {
  const GpsPermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissões GPS'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Configurações de GPS', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class FavoriteSpotsScreen extends StatelessWidget {
  const FavoriteSpotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pistas Favoritas'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Suas pistas favoritas', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class SearchRadiusScreen extends StatelessWidget {
  const SearchRadiusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raio de Busca'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Configurar raio de busca', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Central de Ajuda'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Central de ajuda', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar Problema'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Reportar problema', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o App'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('SkateFlow v1.0.0', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termos de Uso'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Termos de uso', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}