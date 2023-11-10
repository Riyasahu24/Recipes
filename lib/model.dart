class Recipemodel {
  late String applabel;
  late String appimageurl;
  late double appcalories;
  late String appurl;

  Recipemodel(
      {this.applabel = "label",
      this.appimageurl = "image",
      this.appcalories = 0.00,
      this.appurl = "url"});

  factory Recipemodel.fromMap(Map recipe) {
    return Recipemodel(
        applabel: recipe["label"],
        appcalories: recipe["calories"],
        appimageurl: recipe["image"],
        appurl: recipe["url"]);
  }
}
