import 'dart:convert';
import 'dart:developer';

import 'package:employee_app/models/employee/employee_model.dart';
import 'package:employee_app/utils/meta_strings.dart';
import 'package:http/http.dart' as http;

//This repository provides all the api calls and methods available for the employee
class EmployeeRepository {
  static String baseUrl = MetaStrings.baseUrl;
  Future<List<EmployeeModel>> getAllEmployees(
    int pageNumber, {
    String? sortByColumn,
    Map<String, String>? filters,
  }) async {
    try {
      String url =
          "$baseUrl?page=$pageNumber&limit=10${sortByColumn != null && sortByColumn.trim().isNotEmpty ? "&sortBy=$sortByColumn" : ''}";
      if (filters != null && filters.isNotEmpty) {
        filters.forEach((key, value) {
          url += "&$key=$value";
        });
      }
      http.Response response = await http.get(Uri.parse(url));
      log(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)
                .map<EmployeeModel>((data) => EmployeeModel.fromJson(data))
                .toList() ??
            [];
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      rethrow;
    }
  }
}
