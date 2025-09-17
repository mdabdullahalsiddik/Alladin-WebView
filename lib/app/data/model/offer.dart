class OfferModel {
  int? id;
  String? banner;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? bannerUrl;

  OfferModel(
      {this.id,
      this.banner,
      this.title,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.bannerUrl});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bannerUrl = json['banner_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner'] = this.banner;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banner_url'] = this.bannerUrl;
    return data;
  }
}
