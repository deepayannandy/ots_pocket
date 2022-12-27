import 'package:http/http.dart' as http;
import 'package:ots_pocket/config/rest_client.dart';
import 'package:ots_pocket/repos/branch_repository.dart';
import 'package:ots_pocket/repos/consumeable_repo.dart';
import 'package:ots_pocket/repos/equipment_repo.dart';
import 'package:ots_pocket/repos/login_repository.dart';
import 'package:ots_pocket/repos/user_repository.dart';
import 'package:retry/retry.dart';

class RepoFactory {
  RestClient? _restClient;
  static final RepoFactory _instance = RepoFactory._internal();

  RepoFactory._internal();

  factory RepoFactory() {
    _instance._restClient = RestClient(
      httpClient: http.Client(),
      retryOption: RetryOptions(
        maxAttempts: 3,
        maxDelay: Duration(seconds: 1),
        delayFactor: Duration(milliseconds: 2000),
      ),
    );
    return _instance;
  }

  BranchRepository get getBranchRepository =>
      BranchRepository(restClient: _restClient);

  UserRepository get getUserRepository =>
      UserRepository(restClient: _restClient);


  LoginRepository get getLoginRepository =>
      LoginRepository(restClient: _restClient);

  ConsumableRepository get getConsumeableRepository =>
      ConsumableRepository(restClient: _restClient);
      
  EquipmentRepository get getEquipmentRepository =>
      EquipmentRepository(restClient: _restClient);
}
