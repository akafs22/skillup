class Funcionario {
  final int id;
  final String nome;
  final String cpf;
  final String password;
  final String telefone;
  final String tipo;

Funcionario({required this.id, required this.nome, required this.cpf, required this.password, required this.telefone, required this.tipo});

Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'password': password,
      'telefone': telefone,
      'tipo' : tipo,
    };
  }

  factory Funcionario.fromJson(Map<String, dynamic> json) {
    return Funcionario(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      password: json['password'],
      telefone: json['telefone'],
      tipo: json['tipo']
    );
  }
}