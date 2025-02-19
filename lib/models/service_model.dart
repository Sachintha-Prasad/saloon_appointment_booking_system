class ServiceModel {
  final String? id;
  final String name;
  final int duration;
  final int price;
  final String serviceImageUrl;

  ServiceModel({
    this.id,
    required this.name,
    required this.duration,
    required this.price,
    required this.serviceImageUrl
  });


  // factory method to read json data
  factory ServiceModel.fromJson(Map<String, dynamic> json){
    return ServiceModel(
        id: json["_id"] ?? json["id"],
        name: json["name"] as String,
        duration: json["duration"] as int,
        price: json["price"] as int,
        serviceImageUrl: json["serviceImageUrl"] as String
    );
  }

  // convert ServiceModel to JSON
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {
      "name": name,
      "duration": duration,
      "price": price,
      "serviceImageUrl": serviceImageUrl
    };

    if(id != null) data["_id"] = id;

    return data;
  }

}