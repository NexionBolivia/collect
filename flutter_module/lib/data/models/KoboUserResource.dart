class KoboUserResource {
  final String koboUserId;
  final List<String> assets;
  final List<KoboUserOrganization> organizations;
  KoboUserResource.fromJson(Map json)
      : this.koboUserId = "${json['koboUserId']}",
        this.assets = json["assets"].map<String>((value) {
          return "";
        }).toList(),
        this.organizations = json["organizations"]
            .map<KoboUserOrganization>(
                (value) => KoboUserOrganization.fromJson(value))
            .toList();
}

class KoboUserOrganization {
  String organizationId;
  String name;
  String color;
  String profileId;
  KoboUserOrganization.fromJson(Map json)
      : this.organizationId = json['organizationId'],
        this.name = json['name'],
        this.color = json['color'],
        this.profileId = json['profileId'];
}
