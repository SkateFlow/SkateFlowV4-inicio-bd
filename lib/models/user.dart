import 'dart:convert';

class Usuario {
  int? id;
  String nome;
  String email;
  String senha;
  String nivelAcesso;
  String? statusUsuario;
  String? dataCadastro;
  String? foto; // codificado em base64

  Usuario({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.nivelAcesso,
    this.statusUsuario,
    this.dataCadastro,
    this.foto,
  });

  /// Converte um JSON em um objeto Usuario
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      nivelAcesso: json['nivelAcesso'],
      statusUsuario: json['statusUsuario'],
      dataCadastro: json['dataCadastro'],
      foto: json['foto'] != null ? base64Encode(List<int>.from(json['foto'])) : null,
    );
  }

  /// Converte um objeto Usuario em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'nivelAcesso': nivelAcesso,
      'statusUsuario': statusUsuario,
      'dataCadastro': dataCadastro,
      'foto': foto != null ? base64Decode(foto!) : null,
    };
  }
}