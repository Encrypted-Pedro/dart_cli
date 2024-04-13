import 'package:args/command_runner.dart';

import '../src/commands/users/users_command.dart';

void main(List<String> arguments) {
  CommandRunner('Dart CLI', 'Linha de comando para recuperar dados em api')
    ..addCommand(UsersCommand())
    ..run(arguments);
}
