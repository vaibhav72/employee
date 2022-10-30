part of 'checkin_cubit.dart';

class CheckinState extends Equatable {
  

  @override
  List<Object> get props =>  [];
}

class CheckinInitial extends CheckinState {
  @override
  List<Object> get props => [];
}

class CheckinLoading extends CheckinState {
    List<CheckinModel> oldList;
    bool isFirstFetch;
  CheckinLoading({
   required this.oldList,this.isFirstFetch=false
  });
  @override
  List<Object> get props => [oldList,isFirstFetch];
}

class CheckinLoaded extends CheckinState {
  List<CheckinModel> employeeList;
  CheckinLoaded(
     this.employeeList );
  

  @override
  List<Object> get props => [employeeList];
}



class CheckinLoadError extends CheckinState {
  final String errorMessage;

  CheckinLoadError(this.errorMessage);

  @override
  List<Object> get props => [];
}