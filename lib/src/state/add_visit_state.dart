import '../model/add_visit_model.dart';

abstract class AddVisitState {
  void refreshData(AddVisitModel addVisitModel);
  void onSuccess(String success);
  void onError(String error);
}
