class Usuario {
  final String? id; // 🔹 id agora é opcional
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
      if (id != null) 'id': id, // só envia se existir
      'nome': nome,
      'email': email,
      'senha': senha,
      'fotoPerfil': fotoPerfil,
      'dataCriacao': dataCriacao.toIso8601String(),
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
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
