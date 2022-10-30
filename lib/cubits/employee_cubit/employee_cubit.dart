import 'dart:developer';

import 'package:employee_app/models/employee/employee_model.dart';
import 'package:employee_app/repository/employee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository _employeeRepository;
  EmployeeCubit(EmployeeRepository employeeRepository)
      : _employeeRepository = employeeRepository,
        super(EmployeeInitial('', <String, String>{}));
  int page = 1;
  bool isFetching = false;
  bool noMoreData = false;
  String sortBy = '';
  Map<String, String> filters = {};
/*
isFetching is a boolean variable used check if the api call is done for the first time. This later helps us in the presentation layer to display the progress indicators accordingly
page tracks the pagenumber during the pagination.
sortBy is a string that tracks the current column name that is used to sort the data
filters is a key value pair which tracks all the filters applied to the data
*/
  loadEmployees() async {
    try {
      if (noMoreData) return;
      if (state is EmployeeLoading) return;
      List<EmployeeModel> oldEmployeeList = [];
      if (state is EmployeeLoaded && page != 1) {
        oldEmployeeList.addAll((state as EmployeeLoaded).employeeList);
      }
      //The firstFetch is true only if the page number =1
      emit(
        EmployeeLoading(sortBy, filters,
            oldList: oldEmployeeList, isFirstFetch: page == 1),
      );
      List<EmployeeModel> currentList =
          await _employeeRepository.getAllEmployees(page, sortByColumn: sortBy,filters: filters);

      if (currentList.isNotEmpty) {
        page++;
      } else {
        noMoreData = true;
      }
      oldEmployeeList.addAll(currentList);
      emit(EmployeeLoaded(sortBy, filters, oldEmployeeList));
    } catch (e) {
      emit(EmployeeLoadError(sortBy, filters, e.toString()));
    }
  }

  sortEmployees(String sortByalue) {
    sortBy = sortByalue;
    log(sortBy);
    noMoreData = false;
    page = 1;
    loadEmployees();
  }

  addFilter(String filterName, String filterValue) {
    filters[filterName] = filterValue;
    noMoreData = false;
    page = 1;
    loadEmployees();
  }

  removeFilter(String filterName) {
    filters.remove(filterName);
    noMoreData = false;
    page = 1;
    loadEmployees();
  }

  clearFilters() {
    filters.clear();
    noMoreData = false;
    page = 1;
    loadEmployees();
  }
}
