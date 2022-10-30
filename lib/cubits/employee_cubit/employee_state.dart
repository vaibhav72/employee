// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'employee_cubit.dart';

class EmployeeState extends Equatable {
 final String sortBy;
 final Map<String,String> filters;

  EmployeeState(this.sortBy, this.filters);

  @override
  List<Object> get props =>  [sortBy,filters];
}

class EmployeeInitial extends EmployeeState {
  EmployeeInitial(super.sortBy, super.filters);


  @override
  List<Object> get props => [];
}

class EmployeeLoading extends EmployeeState {
    List<EmployeeModel> oldList;
    bool isFirstFetch;
  EmployeeLoading(String sortBy, Map<String,String> filters,{
   required this.oldList,this.isFirstFetch=false
  }) : super(sortBy, filters);
  @override
  List<Object> get props => [oldList,isFirstFetch];
}

class EmployeeLoaded extends EmployeeState {
  List<EmployeeModel> employeeList;
  EmployeeLoaded(String sortBy, Map<String,String> filters,
     this.employeeList ) : super(sortBy, filters);
  

  @override
  List<Object> get props => [employeeList];
}



class EmployeeLoadError extends EmployeeState {
  final String errorMessage;

  EmployeeLoadError(String sortBy, Map<String,String> filters,this.errorMessage) : super(sortBy,filters);

  @override
  List<Object> get props => [];
}
