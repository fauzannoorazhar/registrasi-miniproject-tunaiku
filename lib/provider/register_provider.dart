import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:register_tunaiku/models/register.dart';
import 'package:register_tunaiku/models/register_validate.dart';

class RegisterProvider extends ChangeNotifier {
    double progressInput = 0;

    RegisterValidate _nationalID = RegisterValidate(null,null);
    bool _validnationalID = false;
    RegisterValidate _fullName = RegisterValidate(null,null);
    bool _validfullName = false;
    RegisterValidate _bankAccount = RegisterValidate(null,null);
    bool _validbankAccount = false;
    RegisterValidate _dateOfBirth = RegisterValidate(null,null);
    bool _validdateOfBirth = false;

    RegisterValidate _domicileAddress = RegisterValidate(null,null);
    bool _validdomicileAddress = false;
    RegisterValidate _noAddress = RegisterValidate(null,null);
    bool _validnoAddress = false;

    bool _validPersonalData = false;
    bool _validIDCardAddress = false;
    
    RegisterValidate get nationalID => this._nationalID;
    bool get validnationalID => this._validnationalID;
    RegisterValidate get fullName => this._fullName;
    RegisterValidate get bankAccount => this._bankAccount;
    RegisterValidate get dateOfBirth => this._dateOfBirth;

    bool get validPersonalData => this._validPersonalData;
    bool get validIDCardAddress => this._validIDCardAddress;

    RegisterValidate get domicileAddress => this._domicileAddress;
    RegisterValidate get noAddress => this._noAddress;

    void countProgressInput() {
        if (this.validPersonalData) {
            this.progressInput = 5;
        }

        if (this.validIDCardAddress) {
            this.progressInput = 9;
        }
    }

    String getPercentProgressInput() {
        double count = this.progressInput / 9 * 100; 
        String finalCount = count.toString();
        
        if (finalCount.length >= 3) {
            return finalCount.substring(0, 3);
        }

        return finalCount;
    }

    // setter
    void setNationalID(String value) {
        if (value.length == 16) {
            this._nationalID = RegisterValidate(value, null);
            this._validnationalID = true;
        } else if (value.length <= 16) {
            this._nationalID = RegisterValidate(value, 'National ID should be 16 Character');
            this._validnationalID = false;
        }

        notifyListeners();
    }
    
    // setter
    void setFullname(String value) {
        if (value.isNotEmpty) {
            this._fullName = RegisterValidate(value, null);
            this._validfullName = true;
        } else { 
            this._fullName = RegisterValidate(null, "Fullname cannot be empty"); 
            this._validfullName = false;
        } 

        notifyListeners();
    }
    
    // setter
    void setBankAccount(String value) {
        if (value.isNotEmpty) {
            this._bankAccount = RegisterValidate(value, null);
            this._validbankAccount = true;
        } else { 
            this._bankAccount = RegisterValidate(null, "Fullname cannot be empty"); 
            this._validbankAccount = false;
        } 

        notifyListeners();
    }

    // setter
    void setDateOfBirth(String value) {
        if (value.isNotEmpty) {
            this._dateOfBirth = RegisterValidate(value, null);
            this._validdateOfBirth = true;
        } else { 
            this._dateOfBirth = RegisterValidate(null, "Date Of Birth cannot be empty"); 
            this._validdateOfBirth = false;
        } 

        notifyListeners();
    }

    // setter
    void setDomicileAddress(String value) {
        if (value.isNotEmpty) {
            this._domicileAddress = RegisterValidate(value, null);
            this._validdomicileAddress = true;
        } else { 
            this._domicileAddress = RegisterValidate(null, "Domicile Address can not be empty cannot be empty"); 
            this._validdomicileAddress = false;
        } 

        notifyListeners();
    }

    // setter
    void setNoAddress(String value) {
        if (value.isNotEmpty) {
            this._noAddress = RegisterValidate(value, null);
            this._validnoAddress = true;
        } else { 
            this._noAddress = RegisterValidate(null, "No Address can not be empty"); 
            this._validnoAddress = false;
        } 

        notifyListeners();
    }

    void setValidatePersonalData(Register register) {
        if (this._validnationalID && this._validfullName && this._validbankAccount && this._validdateOfBirth && register.education != null) {
            this._validPersonalData = true;
        } else {
            this._validPersonalData = false;
        }

        notifyListeners();
    }

    void setValidateIDCardAddress(Register register) {
        if (this._validdomicileAddress && this._validnoAddress && register.idProvince != null && register.housingType != null) {
            this._validIDCardAddress = true;
        } else {
            this._validIDCardAddress = false;
        }
    }

    @override 
    void dispose() { 
        super.dispose(); 
    }
}