import 'package:employee_app/models/checkin/checkin_model.dart';

import 'package:employee_app/repository/checkin_repository.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkin_state.dart';

class CheckinCubit extends Cubit<CheckinState> {
  final CheckinRepository _checkinRepository;
  CheckinCubit(CheckinRepository checkinRepository)
      : _checkinRepository = checkinRepository,
        super(CheckinInitial());
  int page = 1;
  bool isFetching = false;
  bool noMoreFunds=false;

  loadCheckins() async {
    try {
      if(noMoreFunds)return;
      if (state is CheckinLoading) return;
      List<CheckinModel> oldCheckinList = []; 
      if (state is CheckinLoaded) {
        oldCheckinList = (state as CheckinLoaded).employeeList ?? [];
           
      }
      emit(
        CheckinLoading(oldList: oldCheckinList, isFirstFetch: page == 1),
      );
      List<CheckinModel> currentList =
          await _checkinRepository.getAllCheckinForEmployee(page);
        
      if (currentList.isNotEmpty) {
        page++;
      }else{
        noMoreFunds=true;
      }
      oldCheckinList.addAll(currentList);
      emit(CheckinLoaded(oldCheckinList));
    } catch (e) {
      emit(CheckinLoadError(e.toString()));
    }
  }
}
