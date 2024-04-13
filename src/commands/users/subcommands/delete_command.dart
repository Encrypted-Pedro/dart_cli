import 'dart:io';
import 'package:args/command_runner.dart';
import '../../../repositories/bound_dio_repository.dart';

class DeleteCommand extends Command {
  BoundDioRepository boundRepository;

  @override
  String get description => 'Remover um vínculo por id';

  @override
  String get name => 'delete';

  DeleteCommand(this.boundRepository) {
    argParser.addOption('id', help: 'Id do vínculo a ser removido', abbr: 'i');
  }

  @override
  Future<void> run() async {
    print('Aguarde...');
    final id = argResults?['id'];
    if (id == null) {
      print('Por favor informe o id do vínculo com o comando --id=0 ou -i=0');
      return;
    }
    final bound = await boundRepository.findById(int.parse(id));
    print('Confirma a remoção de ${bound.name} (S ou N)?');
    final resposta = stdin.readLineSync();
    if (resposta?.toLowerCase() == 's') {
      print('Aguarde, removendo vínculo');
      print('----------------------------------------------');
      await boundRepository.deleteById(int.parse(id));
      print('Vínculo removido com sucesso');
    } else {
      print('Operação cancelada');
    }
  }
}
