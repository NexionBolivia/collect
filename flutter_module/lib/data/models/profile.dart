class Profile {
  Profile.fromJson(Map json)
      : this.id = json["id"],
        this.userName = json["userName"],
        this.password = json["password"],
        this.name = json["name"],
        this.formation = json["formation"],
        this.address = json["address"],
        this.phone = json["phone"],
        this.professionals = json["professionals"],
        this.employes = json["employes"],
        this.department = json["department"],
        this.province = json["province"],
        this.municipality = json["municipality"],
        this.waterConnections = json["waterConnections"],
        this.connectionsWithMeter = json["connectionsWithMeter"],
        this.connectionsWithoutMeter = json["connectionsWithoutMeter"],
        this.publicPools = json["publicPools"],
        this.latrines = json["latrines"],
        this.serviceContinuity = json["serviceContinuity"];

  final String id;
  final String userName;
  final String password;
  final String name;
  final String formation;
  final String address;
  final String phone;
  final int professionals;
  final int employes;
  final String department;
  final String province;
  final String municipality;
  final int waterConnections;
  final int connectionsWithMeter;
  final int connectionsWithoutMeter;
  final int publicPools;
  final int latrines;
  final String serviceContinuity;

  Profile(this.id, this.userName, this.password, this.name, this.formation, this.address, this.phone, this.professionals, this.employes, this.department, this.province, this.municipality, this.waterConnections, this.connectionsWithMeter, this.connectionsWithoutMeter, this.publicPools, this.latrines, this.serviceContinuity);
}
