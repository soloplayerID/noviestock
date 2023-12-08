import '../model/add_stock_model.dart';

abstract class AddStockState {
  void refreshData(AddStockModel addStockModel);
  void onSuccess(String success);
  void onError(String error);
}
