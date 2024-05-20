class AppRoles {
  static String customer = "customer", eventManager = "event_manager";
}

// class Categories {
//   static String weddingVenues = "Wedding Venues", decor = "Decor";
//   static String catering = "Catering", photography = "Photography";
// }

class UserModel {
  String name, email, uid, phoneNumber, role, profileImage;
  String countryCode,
      idCardNo,
      address,
      education,
      experience,
      skills,
      about,
      featureImage;
  List<String> featuredImages, categories;
  double rate;
  bool isComplete = false;

  static const String defaultProfileImage =
      "https://static-00.iconduck.com/assets.00/user-icon-2048x2048-ihoxz4vq.png";

  UserModel({
    required this.email,
    required this.uid,
    required this.phoneNumber,
    required this.role,
    required this.profileImage,
    required this.name,
    required this.address,
    required this.categories,
    required this.countryCode,
    required this.education,
    required this.experience,
    required this.featuredImages,
    required this.idCardNo,
    required this.skills,
    required this.about,
    required this.featureImage,
    this.isComplete = false,
    this.rate = 0,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    UserModel userModelBean = UserModel(
      email: map['email'],
      uid: map['uid'],
      phoneNumber: map['phone_number'] ?? "",
      role: map['role'] ?? "",
      profileImage: map['profile_image'] ?? defaultProfileImage,
      name: map['name'] ?? "",
      address: map['address'] ?? "",
      categories: List<String>.from(
        map['categories'] ?? [],
      ),
      countryCode: map['country_code'] ?? "",
      education: map['education'] ?? "",
      experience: map['experience'] ?? "",
      featuredImages: List<String>.from(
        map['featured_images'] ?? [],
      ),
      idCardNo: map['id_card_no'] ?? "",
      skills: map['skills'] ?? "",
      isComplete: map['is_complete'] ?? false,
      rate: map['rate'] == null ? 0.0 : double.parse("${map['rate']}"),
      about: map['about'] ?? "",
      featureImage: map['feature_image'] ?? "",
    );
    return userModelBean;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email,
      "uid": uid,
      "phone_number": phoneNumber,
      "role": role,
      "profile_image": profileImage,
      "name": name,
      "address": address,
      "categories": categories,
      "country_code": countryCode,
      "education": education,
      "experience": experience,
      "featured_images": featuredImages,
      "id_card_no": idCardNo,
      "skills": skills,
      "about": about,
      "is_complete": isComplete,
      "rate": rate,
      "feature_image": featureImage,
    };
    return map;
  }
}
