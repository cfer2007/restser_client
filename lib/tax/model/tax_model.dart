class TaxModel {
  int? idTax;
  String? name;
  int? percentage;
  //BranchModel? branch;

  TaxModel({
    this.idTax,
    this.name,
    this.percentage,
    //this.branch,
  });

  factory TaxModel.fromJson(Map<String, dynamic> json) {
    return TaxModel(
      idTax: json['idTax'],
      name: json['name'],
      percentage: json['percentage'],
      //branch: BranchModel.fromJson(json['branch']),
    );
  }
}