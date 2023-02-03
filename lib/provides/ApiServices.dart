import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../utils/api.dart';
import '../utils/globals.dart';

class ApiServices {
  static var timeoutrespon = {"status": false, "message": "timeout"};
  static var successResp = {'status': true, "message": "response fetched"};
  static var falseResp = {"status": false, "message": "failed to get response"};
  static String authroziation = "Bearer ${Global.token}";
  // Api for Login username or Password Verification
  Future loginUserVerifyApi(data) async {
    try {
      var data1 = json.encode(data);
      Map<String, String> headers1 = {
        "Content-Type": "application/json",
      };
      var response = await http.post(Uri.parse(Api.fetchScheme),
          body: data1, headers: headers1);
      return response.body.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // Api for sign up
  Future signUpUser(data) {
    return postData(Uri.parse(Api.signUp), data);
  }

  // Api for creation of scheme after required details are entered
  Future createScheme(data) {
    return postData(Uri.parse(Api.createScheme), data);
  }

  // Api for updation of scheme
  Future updateScheme(data, schemeId) {
    String url = Api.updateScheme + schemeId;
    return postData(Uri.parse(url), data);
  }

  // Api to get all scheme providers name and their ID
  Future listSchemeProviderList() async {
    try {
      Map<String, String> userheader = {
        "Content-Type": "application/json",
        "Authorization": authroziation
      };
      var resp = await http.get(Uri.parse(Api.listAllProviderScheme),
          headers: userheader);
      if (resp.statusCode == 200) {
        return resp.body;
      } else {
        return falseResp;
      }
    } on TimeoutException catch (e) {
      return timeoutrespon;
    } catch (e) {
      if (kDebugMode) print("error ---- $e");
    }
  }

  //Api to get all the application from the BAP users
  Future getAppliedSchemes() async {
    try {
      Map<String, String> userheader = {
        "Content-Type": "application/json",
        "Authorization": authroziation
      };
      var resp = await http.get(Uri.parse(Api.appliedSchemesList),
          headers: userheader);
      if (resp.statusCode == 200) {
        return resp.body;
      } else {
        return falseResp;
      }
    } on TimeoutException catch (e) {
      return timeoutrespon;
    } catch (e) {
      if (kDebugMode) print("error ---- $e");
    }
  }

  // to get all the list of created schemes
  Future homeApi() async {
    try {
      Map<String, String> headers1 = {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${Global.token}'
      };

      var response =
          await http.get(Uri.parse(Api.getSchemeList), headers: headers1);

      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 401) {
        return falseResp;
      } else {}
    } catch (e) {
      return e.toString();
    }
  }

  // to publish scheme for the BAP users to apply but we need the scheme ID for it
  Future publishScheme(data, schemeId) {
    String url = Api.publish + schemeId;
    return postData(Uri.parse(url), data);
  }

  // based on application BPP user can accept the application
  Future acceptApplication(data, appId) {
    String url = Api.acceptAppliedSchemesList + appId;
    return postData(Uri.parse(url), data);
  }

  // based on application BPP user can reject the application
  Future rejectApplication(data, appId) {
    String url = Api.rejectAppliedSchemesList + appId;
    return postData(Uri.parse(url), data);
  }

  // to unpublish scheme but we need the scheme ID for it
  Future unpublishScheme(data, schemeId) {
    String url = Api.unpublish + schemeId;
    return postData(Uri.parse(url), data);
  }

  // for the deletion of the scheme
  Future Delete(data, schemeId) {
    String url = Api.delete + schemeId;
    return postData(Uri.parse(url), data);
  }

  // common post data functions for all the api's
  static Future<dynamic> postData(url, body) async {
    Map<String, String> userheader = {
      "Content-Type": "application/json",
      "Authorization": authroziation
    };
    try {
      var resp =
          await http.post(url, body: json.encode(body), headers: userheader);

      if (resp.statusCode == 201) {
        return json.decode(resp.body);
      } else if (resp.statusCode == 200) {
        if (resp.body.toString() == "true") {
          return successResp;
        } else {
          return json.decode(resp.body);
        }
      } else if (resp.statusCode == 415) {
        return falseResp;
      } else if (resp.statusCode == 500) {
        return falseResp;
      } else {
        return falseResp;
      }
    } on TimeoutException catch (e) {
      return timeoutrespon;
    } catch (e) {
      if (kDebugMode) print("error ---- $e");
    }
  }
}
