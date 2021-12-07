import '/table/model/branch_model.dart';

class TableModel {
  int? idTable;
  int? size;
  String? location;
  BranchModel? branch;

  TableModel({
    this.idTable,
    this.size,
    this.location,
    this.branch,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      idTable: json['idTable'],
      size: json['size'],
      location: json['location'],
      branch: BranchModel.fromJson(json['branch']),
    );
  }
}
