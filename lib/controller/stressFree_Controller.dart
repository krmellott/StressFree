import '../model/stressFree_Model.dart';

class stressFree_Controller {
  final modelReference = new stressFree_Model();

  /// {'name':<string>, 'status':<bool>, 'date':{'month':<int>,'day':<int>,'year':<int>}}
  void insertActivityData(String name, bool status, List date) {
    print("ctrllr.insertActivityData{" +
        name +
        ", " +
        status.toString() +
        ", " +
        date[0].toString() +
        date[1].toString() +
        date[2].toString() +
        "}");
    modelReference.dbInsertActivity(name, status, date);
  }
}
