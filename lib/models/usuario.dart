class Usuario {
  final int? id; // 🔹 id agora é um inteiro opcional
  final String nome;
  final String email;
  final String? senha; // opcional para casos de retorno do backend
  final String? fotoPerfil;
  final DateTime dataCriacao;

  Usuario({
    this.id, // opcional
    required this.nome,
    required this.email,
    this.senha,
    this.fotoPerfil,
    required this.dataCriacao,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id.toString(), // Envia o id como string caso exista
      'nome': nome,
      'email': email,
      'senha': senha,
      'fotoPerfil': fotoPerfil,
      'dataCriacao': dataCriacao.toIso8601String(),
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] != null ? map['id'] as int? : null, // Recebe id como inteiro
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      senha: map['senha'],
      fotoPerfil: map['fotoPerfil'],
      dataCriacao: DateTime.parse(
        map['dataCriacao'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario.fromMap(json);
  }
}
