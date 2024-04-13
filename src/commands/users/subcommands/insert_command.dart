import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address.dart';
import '../../../models/bound.dart';
import '../../../models/city.dart';
import '../../../models/paid_verify.dart';
import '../../../models/phone.dart';
import '../../../repositories/bound_dio_repository.dart';
import '../../../repositories/product_dio_repository.dart';

class InsertCommand extends Command {
  final BoundDioRepository boundRepository;
  final ProductDioRepository productRepository;
  @override
  String get description => 'Inserir vínculo';

  @override
  String get name => 'insert';

  InsertCommand(this.boundRepository)
      : productRepository = ProductDioRepository() {
    argParser.addOption('file', help: 'Caminho do arquivo csv', abbr: 'f');
  }

  @override
  Future<void> run() async {
    print('Aguarde...');
    final filePath = argResults?['file'];
    final bounds = File(filePath).readAsLinesSync();
    print('----------------------------------------------');
    for (var bound in bounds) {
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
      final boundToInsert = Bound(
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
      await boundRepository.insert(boundToInsert);
    }
    print('Alunos adicionados com sucesso');
  }
}
