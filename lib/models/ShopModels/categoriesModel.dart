// class CategoriesModel
// {
//   bool? status;
//   CategoriesDataModel? data;

//   CategoriesModel.fromjson(Map<dynamic,dynamic>json){
//     status = json['status'];
//     data = CategoriesDataModel.fromjson(json['data']) ;

//   }
// }


// class CategoriesDataModel
// {
// int? currentPage;
// List<DataModel> data= [];
// CategoriesDataModel.fromjson(Map<dynamic, dynamic> json)
// {
//   currentPage = json['current_page'];
//  json['data'].forEach((element) {
//       data.add(DataModel.fromjson(element));
//     });
// }

// }

// class DataModel
// {int ?id;
// String? name;
// String?image;
// DataModel.fromjson(Map<dynamic,dynamic>json)
// {
//   id = json['id'];
// name = json['name'];
// image = json['image'];
// }

// }