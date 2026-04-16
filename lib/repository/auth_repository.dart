import 'package:bloc_pattern/config/app_url.dart';
import 'package:bloc_pattern/models/auth/login_model.dart';

import '../data/network/dio_api_manager.dart';

class AuthRepository {
  final DioAPIManager dioAPIManager;

  AuthRepository({DioAPIManager? dioAPIManager}) : dioAPIManager = dioAPIManager ?? DioAPIManager();

  Future<LoginModel?> loginApi({required dynamic body}) async {
    final jsonData = await dioAPIManager.postAPICall(
      url: AppUrl.loginApi,
      body: body,
    );
    if (jsonData == null) return null;
    return LoginModel.fromJson(jsonData);
  }
}
