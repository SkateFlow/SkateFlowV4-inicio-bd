import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';

class UsuarioService {
  static const String _baseUrl = 'http://localhost:8080'; // Ajuste se necessário

  // ------------------------------
  // LOGIN DO USUÁRIO
  // ------------------------------
  static Future<Usuario?> loginUsuario(String email, String senha) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/usuario/login'),
            headers: {
              'Content-Type': 'application/json',
              'Access-Control-Allow-Origin': '*',
            },
            body: jsonEncode({'email': email, 'senha': senha}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Usuario.fromJson(jsonDecode(response.body));
      } else {
        print('Erro HTTP login: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro de conexão login: $e');
      rethrow;
    }
  }

  // ------------------------------
  // CADASTRO DE USUÁRIO
  // ------------------------------
  static Future<Usuario?> cadastrarUsuario(Usuario usuario) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/usuario/save'),
            headers: {
              'Content-Type': 'application/json',
              'Access-Control-Allow-Origin': '*',
            },
            body: jsonEncode(usuario.toMap()), // Envia todos os campos do model
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        // Cria o objeto Usuario a partir da resposta do backend
        return Usuario.fromJson(jsonDecode(response.body));
      } else {
        print('Erro HTTP cadastro: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro de conexão cadastro: $e');
      rethrow;
    }
  }
}
