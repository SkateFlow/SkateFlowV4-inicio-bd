class Usuario {
  final String id;
  final String nome;
  final String email;
  final String? fotoPerfil;
  final DateTime dataCriacao;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    this.fotoPerfil,
    required this.dataCriacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'fotoPerfil': fotoPerfil,
      'dataCriacao': dataCriacao.toIso8601String(),
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      fotoPerfil: map['fotoPerfil'],
      dataCriacao: DateTime.parse(map['dataCriacao'] ?? DateTime.now().toIso8601String()),
    );
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario.fromMap(json);
  }
}