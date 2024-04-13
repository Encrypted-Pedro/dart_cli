import 'package:args/command_runner.dart';

import '../../repositories/bound_dio_repository.dart';
import 'subcommands/delete_command.dart';
import 'subcommands/find_all_command.dart';
import 'subcommands/find_by_id_command.dart';
import 'subcommands/insert_command.dart';
import 'subcommands/update_command.dart';

class UsersCommand extends Command {
  @override
  String get description => 'Comandos de usuário';

  @override
  String get name => 'users';

  UsersCommand() {
    final userRepository = BoundDioRepository();
    addSubcommand(FindAllCommand(userRepository));
    addSubcommand(FindByIdCommand(userRepository));
    addSubcommand(InsertCommand(userRepository));
    addSubcommand(UpdateCommand(userRepository));
    addSubcommand(DeleteCommand(userRepository));
  }
}
