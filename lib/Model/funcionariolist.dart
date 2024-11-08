class FuncionarioList {
  final int id;
  final String nome;
  final String cpf;
  final String telefone;
  final String tipo;

FuncionarioList({required this.id, required this.nome, required this.cpf, required this.telefone, required this.tipo});

Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
      'tipo' : tipo,
    };
  }

  factory FuncionarioList.fromJson(Map<String, dynamic> json) {
    return FuncionarioList(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      telefone: json['telefone'],
      tipo: json['tipo']
    );
  }
}