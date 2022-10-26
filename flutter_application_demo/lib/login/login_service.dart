import 'package:dio/dio.dart';
import 'package:flutter_application_demo/login/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/dio_client.dart';

class LoginService {
  late final DioClient _dioClient;
  final LoginRequestModel loginRequestModel;

  LoginService(this.loginRequestModel) {
    _dioClient = DioClient();
  }

  Future<LoginResponseModel> userLogin() async {
    LoginResponseModel? loginResponseModel;

    try {
      Response loginResponse = await _dioClient.dio
          .post("user/authenticate", data: loginRequestModel.toJson());

      loginResponseModel = LoginResponseModel.fromJson(loginResponse.data);

      final prefs = SharedPreferences.getInstance();

      prefs.then((pref) {
        pref.setString(
            "jwtToken", (loginResponseModel?.data?.jwtToken).toString());
      });

      //print(loginResponseModel.jwtToken);
    } on DioError catch (e) {
      String errorMsg;

      print(e);

      if (e.response != null) {
        // print('Dio error!');
        // print('STATUS: ${e.response?.statusCode}');
        // print('DATA: ${e.response?.data}');
        // print('HEADERS: ${e.response?.headers}');

        // errorMsg =
        //     "Error! STATUS: ${e.response?.statusCode}  DATA: ${e.response?.data} HEADERS: ${e.response?.headers}";

        // /* ${e.response != null ? (jsonDecode(e.response?.data)["message"]) : ''} */
        final Map<String, dynamic> jsonData = e.response?.data;
        //print(jsonData["message"]);

        errorMsg = "Error! ${jsonData["message"]}";

        print(errorMsg);
      } else {
        // Error due to setting up or sending the request
        errorMsg = "Error sending request! ${e.message}";
        print(errorMsg);
      }

      loginResponseModel =
          LoginResponseModel(status: "Failed", message: errorMsg, data: null);
    }

    return loginResponseModel;
  }
}
