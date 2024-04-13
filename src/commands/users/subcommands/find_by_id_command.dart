import 'package:args/command_runner.dart';

import '../../../repositories/bound_dio_repository.dart';

class FindByIdCommand extends Command {
  final BoundDioRepository boundRepository;
  @override
  String get description => 'Encontrar vínculos pelo Id';

  @override
  String get name => 'byId';

  FindByIdCommand(this.boundRepository) {
    argParser.addOption('id', help: 'Vínculo Id', abbr: 'i');
  }

  @override
  Future<void> run() async {
    final id = int.tryParse(argResults?['id'] ?? '');
    if (id == null) {
      print('É necessário informar o Id para consultar. (Ex.: --id=0 ou -i=0)');
      return;
    }
    print('Aguarde buscando informações...');
    final bound = await boundRepository.findById(id);
    print('---------------------------------------');
    print('Aluno ${bound.name}:');
    print('---------------------------------------');
    print('Nome: ${bound.name}');
    print('Idade: ${bound.age ?? 'Não informado'}');
    print('Produtos: ');
    bound.productBound?.forEach(print);
    print('Endereço');
    print('   ${bound.address?.street}, ${bound.address?.zipCode}');
  }
}
