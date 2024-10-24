class Curso {
  final int id;
  final String nome;
  final String instrucaoUso;
  final int orgaoEmissorId;

Curso({required this.id, required this.nome, required this.instrucaoUso, required this.orgaoEmissorId});

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      id: json['cursoId'],
      nome: json['nome'],
      instrucaoUso: json['observacao'],
      orgaoEmissorId: json['orgaoEmissorId']
    );
  }
}