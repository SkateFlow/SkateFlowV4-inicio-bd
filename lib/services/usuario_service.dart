import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';

class UsuarioService {
  static const String _baseUrl = 'http://localhost:8080'; // Certifique-se de usar o IP correto, se necessário

  // Método para listar usuários
  static Future<List<Usuario>?> listarUsuarios() async {
    try {
      // Exibe a URL da requisição para depuração
      print('Tentando conectar em: $_baseUrl/usuario/listar');
      
      final response = await http.get(
        Uri.parse('$_baseUrl/usuario/listar'),  // Alteração para /usuario/listar
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
      ).timeout(const Duration(seconds: 10));

      print('Status: ${response.statusCode}');
      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        // Parseando a resposta para uma lista de usuários
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Usuario.fromJson(json)).toList();
      } else {
        print('Erro HTTP: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro de conexão: $e');
      rethrow;
    }
  }
}
