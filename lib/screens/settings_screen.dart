import 'package:flutter/material.dart';
import 'settings/settings_screens.dart';
import 'edit_profile_screen.dart' as edit;
import 'change_photo_screen.dart' as photo;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('Perfil', [
            _buildTile(Icons.edit, 'Editar informações pessoais', () => _navigateTo(context, '/edit-profile')),
            _buildTile(Icons.camera_alt, 'Alterar foto de perfil', () => _navigateTo(context, '/change-photo')),
            _buildTile(Icons.privacy_tip, 'Gerenciar privacidade', () => _navigateTo(context, '/privacy')),
          ]),
          _buildSection('App', [
            _buildTile(Icons.language, 'Idioma', () => _navigateTo(context, '/language')),
            _buildTile(Icons.notifications, 'Notificações', () => _navigateTo(context, '/notifications')),
            _buildTile(Icons.volume_up, 'Som e vibração', () => _navigateTo(context, '/sound')),
          ]),
          _buildSection('Conta', [
            _buildTile(Icons.lock, 'Alterar senha', () => _navigateTo(context, '/change-password')),
            _buildTile(Icons.account_circle, 'Gerenciar conta', () => _navigateTo(context, '/manage-account')),
            _buildTile(Icons.delete_forever, 'Excluir conta', () => _navigateTo(context, '/delete-account'), isDestructive: true),
          ]),
          _buildSection('Localização', [
            _buildTile(Icons.gps_fixed, 'Permissões de GPS', () => _navigateTo(context, '/gps-permissions')),
            _buildTile(Icons.favorite, 'Pistas favoritas', () => _navigateTo(context, '/favorite-spots')),
          ]),
          _buildSection('Suporte', [
            _buildTile(Icons.help, 'Central de ajuda', () => _navigateTo(context, '/help')),
            _buildTile(Icons.report, 'Reportar problema', () => _navigateTo(context, '/report')),
            _buildTile(Icons.info, 'Sobre o app', () => _navigateTo(context, '/about')),
            _buildTile(Icons.description, 'Termos de uso', () => _navigateTo(context, '/terms')),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Card(
          child: Column(children: children),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTile(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : Colors.grey.shade700),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _getScreen(route)),
    );
  }

  Widget _getScreen(String route) {
    switch (route) {
      case '/edit-profile': return const edit.EditProfileScreen();
      case '/change-photo': return const photo.ChangePhotoScreen();
      case '/privacy': return const PrivacyScreen();
      case '/language': return const LanguageScreen();
      case '/notifications': return const NotificationsScreen();
      case '/sound': return const SoundScreen();
      case '/change-password': return const ChangePasswordScreen();
      case '/manage-account': return const ManageAccountScreen();
      case '/delete-account': return const DeleteAccountScreen();
      case '/gps-permissions': return const GpsPermissionsScreen();
      case '/favorite-spots': return const FavoriteSpotsScreen();
      case '/search-radius': return const SearchRadiusScreen();
      case '/help': return const HelpScreen();
      case '/report': return const ReportScreen();
      case '/about': return const AboutScreen();
      case '/terms': return const TermsScreen();
      default: return const Scaffold(body: Center(child: Text('Tela em desenvolvimento')));
    }
  }
}