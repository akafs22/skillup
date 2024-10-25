class Curso {
  final int id;
  final String nome;
  final String descricao;
  final int orgaoEmissorId;

Curso({required this.id, required this.nome, required this.descricao, required this.orgaoEmissorId});

Map<String, dynamic> toJson() {
    return {
      'cursoId': id ?? 0,
      'nome': nome,
      'descricao': descricao,
      'orgaoEmissorId': orgaoEmissorId,
    };
  }

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      id: json['cursoId'],
      nome: json['nome'],
      descricao: json['descricao'],
      orgaoEmissorId: json['orgaoEmissorId']
    );
  }
}