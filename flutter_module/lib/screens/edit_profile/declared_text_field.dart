import 'package:flutter/material.dart';
import 'package:flutter_module/utils/my_text_field.dart';
import 'package:flutter_module/utils/text_edit_validators.dart';

abstract class DeclaredTextField {
  static MyTextField getUsernameField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      enabled: false,
      keyboardType: TextInputType.text,
    );
  }

  static MyTextField getPasswordField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      enabled: false,
      keyboardType: TextInputType.text,
    );
  }

  static MyTextField getNameField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.text,
    );
  }

  static MyTextField getFormationField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.text,
    );
  }

  static MyTextField getAddressField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.text,
    );
  }

  static MyTextField getPhoneField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.text,
    );
  }

  static MyTextField getProfessionalsField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.number,
    );
  }

  static MyTextField getEmployesField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.number,
    );
  }

  static MyTextField getDepartmentField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.text,
    );
  }

  static MyTextField getProvinceField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.text,
    );
  }

  static MyTextField getMunicipalityField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.text,
    );
  }

  static MyTextField getWaterConnectionsField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.number,
    );
  }

  static MyTextField getConnectionsWithMeterField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.number,
    );
  }

  static MyTextField getConnectionsWithoutMeterField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.number,
    );
  }

  static MyTextField getPublicPoolsField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.number,
    );
  }

  static MyTextField getLatrinesField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.number,
    );
  }

  static MyTextField getServiceContinuityField() {
    return MyTextField(
      validator: TextEditValidators.isNotEmpty,
      autoCorrect: false,
      keyboardType: TextInputType.text,
    );
  }
}
