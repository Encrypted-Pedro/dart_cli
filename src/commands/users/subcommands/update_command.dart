import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address.dart';
import '../../../models/bound.dart';
import '../../../models/city.dart';
import '../../../models/paid_verify.dart';
import '../../../models/phone.dart';
import '../../../repositories/bound_dio_repository.dart';
import '../../../repositories/product_dio_repository.dart';

class UpdateCommand extends Command {
  BoundDioRepository boundRepository;
  final productRepository = ProductDioRepository();

  @override
  String get description => 'Atualizar vínculos';

  @override
  String get name => 'update';
  UpdateCommand(this.boundRepository) {
    argParser.addOption('file', help: 'Caminho do arquivo csv', abbr: 'f');
    argParser.addOption('id',
        help: 'Id do vínculo a ser atualizado', abbr: 'i');
  }
  @override
  Future<void> run() async {
    print('Aguarde...');
    final filePath = argResults?['file'];
    final id = argResults?['id'];
    if (id == null) {
      print('Por favor informe o id do vínculo com o comando --id=0 ou -i=0');
      return;
    }
    final bounds = File(filePath).readAsLinesSync();
    print('Aguarde, atualizando vínculos');
    print('----------------------------------------------');
    if (bounds.length > 1) {
      print('Por favor informe somente um aluno no arquivo $filePath');
      return;
    } else if (bounds.isEmpty) {
      print('Por favor informe um aluno no arquivo $filePath');
      return;
    }

    var bound = bounds.first;

    final boundData = bound.split(';');
    final products = boundData[2]
        .split(',')
        .map((e) => e.replaceAll('"', '').trim())
        .toList();
    final productsFuture = products.map((produtos) async {
      final productToBound = await productRepository.findByTittle(produtos);
      productToBound.paid = true;
      return productToBound;
    });
    final productItem = await Future.wait(productsFuture);
    var i = productItem.map((e) {
      return PaidVerify.fromMap(e.toMap());
    }).toList();
    final boundToUpdate = Bound(
        id: int.parse(id),
        name: boundData[0],
        age: int.tryParse(boundData[1]),
        productBound: products,
        paidVerify: i,
        address: Address(
            street: boundData[3],
            number: int.parse(boundData[4]),
            zipCode: bound[5],
            city: City(id: 0, name: boundData[6]),
            phone:
                Phone(ddd: int.tryParse(boundData[7]), phone: boundData[8])));
    await boundRepository.update(boundToUpdate);
    print('Vínculo atualizado com sucesso');
  }
}
