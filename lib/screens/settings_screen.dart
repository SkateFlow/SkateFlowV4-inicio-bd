import 'package:flutter/material.dart';
import 'edit_profile_screen.dart' as edit;
import 'change_photo_screen.dart' as photo;
import 'notifications_settings_screen.dart';
import 'sound_vibration_settings_screen.dart';
import 'help_screen.dart';
import 'manage_account_screen.dart';
import '../main.dart';

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
        title: const Text(
          'Configurações',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3888D2), Color(0xFF043C70)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('Perfil', [
            _buildTile(Icons.edit, 'Informações Pessoais',
                () => _navigateTo(context, '/edit-profile')),
            _buildTile(Icons.camera_alt, 'Alterar Foto de Perfil',
                () => _navigateTo(context, '/change-photo')),
            _buildTile(Icons.privacy_tip, 'Privacidade',
                () => _navigateTo(context, '/privacy')),
          ]),
          _buildSection('App', [
            _buildThemeToggle(),
            _buildTile(Icons.notifications, 'Notificações',
                () => _navigateTo(context, '/notifications')),
            _buildTile(Icons.volume_up, 'Som e vibração',
                () => _navigateTo(context, '/sound')),
          ]),
          _buildSection('Conta', [
            _buildTile(Icons.account_circle, 'Gerenciar conta',
                () => _navigateTo(context, '/manage-account')),
          ]),
          _buildSection('Localização', [
            _buildTile(Icons.gps_fixed, 'Permissão do GPS',
                () => _navigateTo(context, '/gps-permissions')),
          ]),
          _buildSection('Suporte', [
            _buildTile(Icons.help, 'Central de Ajuda',
                () => _navigateTo(context, '/help')),
            _buildTile(Icons.report, 'Reportar Problema',
                () => _navigateTo(context, '/report')),
            _buildTile(Icons.info, 'Sobre o App',
                () => _navigateTo(context, '/about')),
            _buildTile(Icons.description, 'Termos de Uso',
                () => _navigateTo(context, '/terms')),
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        Card(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF2C2C2C)
              : Colors.white,
          child: Column(children: children),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTile(IconData icon, String title, VoidCallback onTap,
      {bool isDestructive = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      child: ListTile(
        leading: Icon(icon,
            color: isDestructive
                ? Colors.red
                : (isDark ? Colors.white70 : Colors.grey.shade700)),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive
                ? Colors.red
                : (isDark ? Colors.white : Colors.black),
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDark ? Colors.white70 : Colors.grey.shade600,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildThemeToggle() {
    final themeProvider = ThemeProvider();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      child: ListTile(
        leading: Icon(
          themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: isDark ? Colors.white70 : Colors.grey.shade700,
        ),
        title: Text(
          'Tema escuro',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Switch(
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            setState(() {
              themeProvider.toggleTheme();
            });
          },
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => _getScreen(route),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget _getScreen(String route) {
    switch (route) {
      case '/edit-profile':
        return const edit.EditProfileScreen();
      case '/change-photo':
        return const photo.ChangePhotoScreen();
      case '/privacy':
        return const Scaffold(body: Center(child: Text("Em desenvolvimento")));

      case '/notifications':
        return const NotificationsSettingsScreen();
      case '/sound':
        return const SoundVibrationSettingsScreen();
      case '/change-password':
        return const ChangePasswordScreen();
      case '/manage-account':
        return const ManageAccountScreen();
      case '/delete-account':
        return const Scaffold(body: Center(child: Text("Em desenvolvimento")));
      case '/gps-permissions':
        return const Scaffold(body: Center(child: Text("Em desenvolvimento")));
      case '/favorite-spots':
        return const Scaffold(body: Center(child: Text("Em desenvolvimento")));
      case '/search-radius':
        return const Scaffold(body: Center(child: Text("Em desenvolvimento")));
      case '/help':
        return const HelpScreen();
      case '/report':
        return _buildReportScreen();
      case '/about':
        return _buildAboutScreen();
      case '/terms':
        return _buildTermsScreen();
      default:
        return const Scaffold(
            body: Center(child: Text('Tela em desenvolvimento')));
    }
  }

  Widget _buildReportScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar Problema',
            style: TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: const Color(0xFF2C2C2C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.bug_report,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Reportar Problema',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ajude-nos a melhorar o SkateFlow reportando problemas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70
                          : Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Descreva o problema',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 6,
              decoration: InputDecoration(
                hintText:
                    'Descreva detalhadamente o problema encontrado...\n\nIncluir informações como:\n• O que você estava fazendo\n• O que esperava que acontecesse\n• O que realmente aconteceu',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF00294F)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Categoria do problema',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF00294F)),
                ),
              ),
              hint: const Text('Selecione uma categoria'),
              items: [
                {'label': 'Bug', 'icon': Icons.bug_report},
                {'label': 'Crash', 'icon': Icons.error},
                {'label': 'Performance', 'icon': Icons.speed},
                {'label': 'Interface', 'icon': Icons.design_services},
                {'label': 'Outro', 'icon': Icons.help_outline},
              ]
                  .map((category) => DropdownMenuItem<String>(
                        value: category['label'] as String,
                        child: Row(
                          children: [
                            Icon(
                              category['icon'] as IconData,
                              size: 20,
                              color: const Color(0xFF00294F),
                            ),
                            const SizedBox(width: 8),
                            Text(category['label'] as String),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF00294F).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: const Color(0xFF00294F).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Color(0xFF00294F)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Sua privacidade é importante. Não incluiremos informações pessoais no relatório.',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white70
                            : const Color(0xFF00294F),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Problema reportado com sucesso! Obrigado pelo feedback.'),
                      backgroundColor: Color(0xFF00294F),
                    ),
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.send),
                label: const Text('Enviar Relatório'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00294F),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o App',
            style: TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: const Color(0xFF2C2C2C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/skateparks/logo-branca.png'
                        : 'assets/images/skateparks/logo-preta.png',
                    height: 160,
                    width: 160,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Versão 1.0.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70
                          : Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF2C2C2C)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade700
                      : Colors.grey.shade200,
                ),
              ),
              child: Text(
                'O SkateFlow é o aplicativo definitivo para skatistas que buscam descobrir as melhores pistas e eventos em sua região. Nossa missão é conectar a vibrante comunidade do skate, facilitando a descoberta de novos spots incríveis e promovendo encontros entre skatistas apaixonados pelo esporte.\n\nCom recursos avançados de localização, avaliações da comunidade e informações detalhadas sobre cada pista, o SkateFlow transforma a experiência de explorar o mundo do skate, tornando cada sessão uma nova aventura.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoCard('Desenvolvido por', 'Equipe SkateFlow', Icons.code),
            _buildInfoCard('Contato', 'suporte@skateflow.com', Icons.email),
            _buildInfoCard('Website', 'www.skateflow.com', Icons.language),
            _buildInfoCard('Suporte', '(11) 94567-8901', Icons.phone),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF00294F).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.favorite,
                    color: const Color(0xFF00294F),
                    size: 24,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Feito com ❤️ para a comunidade do skate',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '© 2025 SkateFlow. Todos os direitos reservados.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termos de Uso',
            style: TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: const Color(0xFF2C2C2C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.description,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Termos de Uso do SkateFlow',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Última atualização: Janeiro 2025',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70
                          : Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _buildTermsSection(
              '1. Aceitação dos Termos',
              'Ao usar o SkateFlow, você concorda com estes termos de uso. Se não concordar, não use o aplicativo.',
            ),
            _buildTermsSection(
              '2. Uso do Aplicativo',
              'O SkateFlow é destinado a skatistas para encontrar pistas e eventos. Você deve usar o app de forma responsável e respeitosa.',
            ),
            _buildTermsSection(
              '3. Privacidade',
              'Respeitamos sua privacidade. Coletamos apenas dados necessários para o funcionamento do app. Consulte nossa Política de Privacidade.',
            ),
            _buildTermsSection(
              '4. Conteúdo do Usuário',
              'Você é responsável pelo conteúdo que compartilha. Não publique conteúdo ofensivo, ilegal ou que viole direitos de terceiros.',
            ),
            _buildTermsSection(
              '5. Limitação de Responsabilidade',
              'O SkateFlow não se responsabiliza por danos decorrentes do uso do aplicativo. Use por sua conta e risco.',
            ),
            _buildTermsSection(
              '6. Modificações',
              'Podemos modificar estes termos a qualquer momento. Continuando a usar o app, você aceita as modificações.',
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF00294F).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: const Color(0xFF00294F).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.contact_support, color: const Color(0xFF00294F)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dúvidas sobre os termos?',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Entre em contato conosco:',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white70
                                    : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'suporte@skateflow.com',
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 22, 63, 100),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, IconData icon) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2C2C2C)
            : Colors.white,
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00294F).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon,
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF4A90E2)
                    : const Color(0xFF00294F),
                size: 20),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          subtitle: Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTermsSection(String title, String content) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2C2C2C)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade700
              : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF4A90E2)
                  : const Color(0xFF00294F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
