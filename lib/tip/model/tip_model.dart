class TipModel {
  int? idTip;
  String? name;
  int? percentage;
  //BranchModel? branch;

  TipModel({
    this.idTip,
    this.name,
    this.percentage,
    //this.branch,
  });

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      idTip: json['idTip'],
      name: json['name'],
      percentage: json['percentage'],
      //branch: BranchModel.fromJson(json['branch']),
    );
  }
}