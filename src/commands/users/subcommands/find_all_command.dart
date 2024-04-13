import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../repositories/bound_dio_repository.dart';

class FindAllCommand extends Command {
  final BoundDioRepository repository;
  @override
  String get description => 'Encontrar todos os usuários';

  @override
  String get name => 'findAll';

  FindAllCommand(this.repository);

  @override
  void run() async {
    print('Aguarde buscando usuários...');
    final bounds = await repository.findAll();
    print('Apresentar as vinculações? (S ou N)');
    final showBounds = stdin.readLineSync();
    print('---------------------------------------');
    print('Usuários');
    print('---------------------------------------');
    for (var bound in bounds) {
      if (showBounds?.toLowerCase() == 's') {
        print(
            '${bound.id} - ${bound.name} ${bound.paidVerify?.where((bound) => bound.paid ?? false).map((e) => e.product).toList()}');
      } else {
        print('${bound.id} - ${bound.name}');
      }
    }
  }
}
