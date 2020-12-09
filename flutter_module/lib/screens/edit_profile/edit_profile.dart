import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_module/data/models/profile.dart';
import 'package:flutter_module/screens/edit_profile/declared_text_field.dart';
import 'package:flutter_module/service/api/set_profile.dart';
import 'package:flutter_module/utils/my_text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key key, @required this.profile}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
  final Profile profile;
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool loading = false;

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  final MyTextField name = DeclaredTextField.getNameField();
  final MyTextField formation = DeclaredTextField.getFormationField();
  final MyTextField address = DeclaredTextField.getAddressField();
  final MyTextField phone = DeclaredTextField.getPhoneField();
  final MyTextField professionals = DeclaredTextField.getProfessionalsField();
  final MyTextField employes = DeclaredTextField.getEmployesField();
  final MyTextField department = DeclaredTextField.getDepartmentField();
  final MyTextField province = DeclaredTextField.getProvinceField();
  final MyTextField municipality = DeclaredTextField.getMunicipalityField();
  final MyTextField waterConnections =
      DeclaredTextField.getWaterConnectionsField();
  final MyTextField connectionsWithMeter =
      DeclaredTextField.getConnectionsWithMeterField();
  final MyTextField connectionsWithoutMeter =
      DeclaredTextField.getConnectionsWithoutMeterField();
  final MyTextField publicPools = DeclaredTextField.getPublicPoolsField();
  final MyTextField latrines = DeclaredTextField.getLatrinesField();
  final MyTextField serviceContinuity =
      DeclaredTextField.getServiceContinuityField();
  @override
  void initState() {
    name.text = widget.profile.name;
    formation.text = widget.profile.formation;
    address.text = widget.profile.address;
    phone.text = widget.profile.phone;
    professionals.text = "${widget.profile.professionals}";
    employes.text = "${widget.profile.employes}";
    department.text = widget.profile.department;
    province.text = widget.profile.province;
    municipality.text = widget.profile.municipality;
    waterConnections.text = "${widget.profile.waterConnections}";
    connectionsWithMeter.text = "${widget.profile.connectionsWithMeter}";
    connectionsWithoutMeter.text = "${widget.profile.connectionsWithoutMeter}";
    publicPools.text = "${widget.profile.publicPools}";
    latrines.text = "${widget.profile.latrines}";
    serviceContinuity.text = widget.profile.serviceContinuity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Perfil"),
      ),
      body: Form(
        key: form,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  name.build(
                    context: context,
                    labelText: "Nombre de la EPSA o CAPyS",
                    disabled: loading,
                    next: formation.focusNode,
                  ),
                  formation.build(
                    context: context,
                    labelText: "Formación de consitución",
                    disabled: loading,
                    next: address.focusNode,
                  ),
                  address.build(
                    context: context,
                    labelText: "Dirección",
                    disabled: loading,
                    next: phone.focusNode,
                  ),
                  phone.build(
                    context: context,
                    labelText: "Telefonos",
                    disabled: loading,
                    next: professionals.focusNode,
                  ),
                  professionals.build(
                    context: context,
                    labelText: "Número de tecnicos y/o profesionales",
                    disabled: loading,
                    next: employes.focusNode,
                  ),
                  employes.build(
                    context: context,
                    labelText: "Número total de empleados",
                    disabled: loading,
                    next: department.focusNode,
                  ),
                  department.build(
                    context: context,
                    labelText: "Departamento",
                    disabled: loading,
                    next: province.focusNode,
                  ),
                  province.build(
                    context: context,
                    labelText: "Provincia",
                    disabled: loading,
                    next: municipality.focusNode,
                  ),
                  municipality.build(
                    context: context,
                    labelText: "Municipio",
                    disabled: loading,
                    next: waterConnections.focusNode,
                  ),
                  waterConnections.build(
                    context: context,
                    labelText: "Numero total de conexiones de agua potable",
                    disabled: loading,
                    next: connectionsWithMeter.focusNode,
                  ),
                  connectionsWithMeter.build(
                    context: context,
                    labelText: "Numero de conexiones con medidor",
                    disabled: loading,
                    next: connectionsWithoutMeter.focusNode,
                  ),
                  connectionsWithoutMeter.build(
                    context: context,
                    labelText: "Numero de conexiones sin medidor",
                    disabled: loading,
                    next: publicPools.focusNode,
                  ),
                  publicPools.build(
                    context: context,
                    labelText: "Numero de piletas publicas",
                    disabled: loading,
                    next: latrines.focusNode,
                  ),
                  latrines.build(
                    context: context,
                    labelText: "Numero de letrinas",
                    disabled: loading,
                    next: serviceContinuity.focusNode,
                  ),
                  serviceContinuity.build(
                    context: context,
                    labelText: "Continuidad del servicio  hr/dia",
                    disabled: loading,
                  ),
                  SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _save,
        tooltip: 'Save',
        child: loading
            ? CircularProgressIndicator(backgroundColor: Colors.white)
            : Icon(Icons.save),
      ),
    );
  }

  _save() {
    if (!loading && form.currentState.validate()) {
      setState(() {
        loading = true;
      });
      SetProfile(
        id: widget.profile.id,
        userName: widget.profile.userName,
        password: widget.profile.password,
        name: name.text,
        formation: formation.text,
        address: address.text,
        phone: phone.text,
        professionals: int.tryParse(professionals.text),
        employes: int.tryParse(employes.text),
        department: department.text,
        province: province.text,
        municipality: municipality.text,
        waterConnections: int.tryParse(waterConnections.text),
        connectionsWithMeter: int.tryParse(connectionsWithMeter.text),
        connectionsWithoutMeter: int.tryParse(connectionsWithoutMeter.text),
        publicPools: int.tryParse(publicPools.text),
        latrines: int.tryParse(latrines.text),
        serviceContinuity: serviceContinuity.text,
      ).fetch().then((value) {
        if (mounted) Navigator.pop(context, true);
      }).catchError((error) {
        log("$error");
        if (mounted)
          setState(() {
            loading = false;
          });
      });
    }
  }
}
