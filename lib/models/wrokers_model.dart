class WorkersModel{
  WorkersModel({
    required this.aadharImage,
    required this.email,
    required this.availability,
    required this.displayName,
    required this.profilePhoto,
    required this.specialization,
    required this.uid,
    required this.rating,
  });
  late final String aadharImage;
  late final String availability;
  late final String email;
  late final String displayName;
  late final String profilePhoto;
  late final String specialization;
  late final String uid;
  late final String rating;


  WorkersModel.fromJson(Map<String, dynamic> json){
    aadharImage = json['aadharImage'] ?? '';
    availability = json['availability']?? '';
    email = json['email']?? '';
    displayName = json['displayName']?? '';
    profilePhoto = json['profilePhoto'] ?? '';
    specialization = json['specialization'] ?? '';
    uid = json['uid'] ?? '';
    rating = json['rating'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aadharImage'] = aadharImage;
    data['availability'] = availability;
    data['email'] = email;
    data['displayName'] = displayName;
    data['profilePhoto'] = profilePhoto;
    data['specialization'] = specialization;
    data['uid'] = uid;
    data['rating']=rating;
    return data;
  }
}