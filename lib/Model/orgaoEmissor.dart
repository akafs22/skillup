class OrgaoEmissor {
  final int id;
  final String nome;

OrgaoEmissor({required this.id, required this.nome});

Map<String, dynamic> toJson() {
    return {
      'orgaoEmissorId': id ?? 0,
      'nome': nome,
    };
  }

  factory OrgaoEmissor.fromJson(Map<String, dynamic> json) {
    return OrgaoEmissor(
      id: json['orgaoEmissorId'],
      nome: json['nome'],
    );
  }
}