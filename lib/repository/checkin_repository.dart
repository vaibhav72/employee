import 'dart:convert';
import 'dart:developer';

import 'package:employee_app/models/checkin/checkin_model.dart';
import 'package:employee_app/models/employee/employee_model.dart';
import 'package:employee_app/utils/meta_strings.dart';
import 'package:http/http.dart' as http;

//This repository provides all the api calls and methods available for the checkin

class CheckinRepository{
 final EmployeeModel employee;
 CheckinRepository(this.employee);
 static const String baseUrl=MetaStrings.baseUrl;

  Future<List<CheckinModel>> getAllCheckinForEmployee(int pageNumber) async {
    try {
      http.Response response =
          await http.get(Uri.parse(baseUrl + "/${employee.id}/checkin?page=$pageNumber&limit=10"));
          log(baseUrl + "${employee.id}/checkin?page=$pageNumber&limit=10");
      if (response.statusCode == 200) {

        return jsonDecode(response.body)
            .map<CheckinModel>((data) => CheckinModel.fromJson(data))
            .toList()??[];
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      rethrow;
    }
  }
}