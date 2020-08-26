import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:register_tunaiku/models/register.dart';
import 'package:register_tunaiku/provider/register_provider.dart';
import 'package:register_tunaiku/ui/widgets/form_field_custome.dart';

class PersonalDataPage extends StatefulWidget {
    String titlePage;
    Register register;
    PageController pageController;

    PersonalDataPage({
        @required this.titlePage,
        @required this.register,
        @required this.pageController
    });

    @override
    _PersonalDataPageState createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
    final _formKey = GlobalKey<FormState>();
    TextEditingController nationalIDController = new TextEditingController();
    TextEditingController fullNameController = new TextEditingController();
    TextEditingController bankAccountController = new TextEditingController();
    TextEditingController dateOfBirthController = new TextEditingController();

    List<String> listEducation = [
        'SD',
        'SMP',
        'SMA',
        'S1',
        'S2',
        'S3'
    ];

    @override
    Widget build(BuildContext context) {
        return Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Expanded(
                        child: NotificationListener<OverscrollIndicatorNotification>(
                            onNotification: (overscroll) {
                                overscroll.disallowGlow();
                            },
                            child: SingleChildScrollView(
                                child: Container(
                                    margin: EdgeInsets.all(15),
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Consumer<RegisterProvider>(
                                                builder: (context, provider, child) {
                                                    return RichText(
                                                        text: TextSpan(
                                                            text: provider.getPercentProgressInput() + '%',
                                                            style: TextStyle(
                                                                color: Color(0xFF5AB11A),
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 30
                                                            ),
                                                            children: <TextSpan>[
                                                            TextSpan(
                                                                text: ' Complete',
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.normal,
                                                                    fontSize: 15
                                                                )),
                                                            ],
                                                        ),
                                                    );
                                                },
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                                this.widget.titlePage,
                                                style: TextStyle(
                                                    color: Color(0xFF5AB11A),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20
                                                ),
                                            ),
                                            SizedBox(height: 50),
                                            fieldNationalID(),
                                            SizedBox(height: 10),
                                            fieldFullName(),
                                            SizedBox(height: 10),
                                            fieldBankAccount(),
                                            SizedBox(height: 10),
                                            fieldEducation(),
                                            SizedBox(height: 25),
                                            fieldDateOfBirth(),
                                            SizedBox(height: 25),
                                        ],
                                    ),
                                )
                            ),
                        ),
                    ),
                    Consumer<RegisterProvider>(
                        builder: (context, provider, child) {
                            return Container(
                                height: 80,
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                child: FlatButton(
                                    color: Color(0xFF5AB11A),
                                    textColor: Colors.white,
                                    disabledColor: Colors.grey,
                                    disabledTextColor: Colors.white,
                                    padding: EdgeInsets.all(8.0),
                                    splashColor: Colors.greenAccent,
                                    onPressed: (provider.validPersonalData) ? () {
                                        provider.countProgressInput();
                                        if (_formKey.currentState.validate()) {
                                            //Future.delayed(const Duration(milliseconds: 1000), () {
                                                this.widget.pageController.jumpToPage(1);
                                                this.widget.register.nationalID = int.parse(nationalIDController.text);
                                                this.widget.register.fullName = fullNameController.text;
                                                this.widget.register.bankAccount = int.parse(bankAccountController.text);
                                                this.widget.register.dateOfBirth = dateOfBirthController.text;
                                           //});
                                        }
                                    } : null,
                                    child: Text(
                                        "Next",
                                        style: TextStyle(fontSize: 15.0),
                                    ),
                                )
                            );
                        },
                    )
                ],
            )
        );
    }

    Widget fieldNationalID() {
        if (this.widget.register.nationalID != null && this.widget.register.nationalID.toString().isNotEmpty) {
            setState(() {
                this.nationalIDController.text = this.widget.register.nationalID.toString();
            });
        }

        return Consumer<RegisterProvider>(
            builder: (BuildContext context, RegisterProvider provider, Widget child) {
                return FormFieldCustome(
                    textLabel: 'National ID ',
                    textFormField: TextFormField(
                        controller: this.nationalIDController,
                        maxLength: 16,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Input Your National ID',
                            errorText: provider.nationalID.error,
                        ), 
                        onChanged: (String value) { 
                            provider.setNationalID(value);
                            provider.setValidatePersonalData(this.widget.register);
                        },
                        validator: (value) {
                            if (value.isEmpty) {
                                return 'National ID cannot be empty';
                            }
                        }, 
                    )
                );
            },
        );
    }

    Widget fieldFullName() {
        if (this.widget.register.fullName != null && this.widget.register.fullName.isNotEmpty) {
            setState(() {
                this.fullNameController.text = this.widget.register.fullName;
            });
        }

        return Consumer<RegisterProvider>(
            builder: (BuildContext context, RegisterProvider provider, Widget child) {
                return FormFieldCustome(
                    textLabel: 'Fullname ',
                    textFormField: TextFormField(
                        controller: this.fullNameController,
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z\\s]")),],
                        maxLength: 10,
                        decoration: InputDecoration(
                            hintText: 'Input Your Fullname',
                            errorText: provider.fullName.error,
                        ), 
                        onChanged: (String value) { 
                            provider.setFullname(value);
                            provider.setValidatePersonalData(this.widget.register);
                        },
                        validator: (value) {
                            if (value.isEmpty) {
                                return 'Fullname cannot be empty';
                            }
                        }, 
                    )
                );
            }
        );
    }

    Widget fieldBankAccount() {
        if (this.widget.register.bankAccount != null && this.widget.register.bankAccount.toString().isNotEmpty) {
            setState(() {
                this.bankAccountController.text = this.widget.register.bankAccount.toString();
            });
        }

        return Consumer<RegisterProvider>(
            builder: (BuildContext context, RegisterProvider provider, Widget child) {
                return FormFieldCustome(
                    textLabel: 'Bank Account ',
                    textFormField: TextFormField(
                        controller: this.bankAccountController,
                        maxLength: 8,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Input Your Bank Account',
                            errorText: provider.bankAccount.error,
                        ),
                        onChanged: (String value) { 
                            provider.setBankAccount(value);
                            provider.setValidatePersonalData(this.widget.register);
                        }, 
                        validator: (value) {
                            if (value.isEmpty) {
                                return 'Bank Account cannot be empty';
                            }
                        }, 
                    )
                );
            }
        );
    }

    Widget fieldEducation() {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                RichText(
                    text: TextSpan(
                        text: 'Education',
                        style: TextStyle(
                            color: Color(0xFF5AB11A),
                            fontWeight: FontWeight.w600
                        ),
                        children: <TextSpan>[
                        TextSpan(
                            text: ' *',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                        ],
                    ),
                ),
                Consumer<RegisterProvider>(
                    builder: (context, provider, child) {
                        return DropdownButtonFormField<String>(
                            hint: Text(
                                "Select Education",
                                overflow: TextOverflow.ellipsis,
                            ),
                            value: (this.widget.register.education == null) ? null : this.widget.register.education,
                            isExpanded: true,
                            items: listEducation.map((String valueDropdown) {
                                return DropdownMenuItem<String>(
                                    value: valueDropdown,
                                    child: Text(
                                        valueDropdown,
                                    ),
                                );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                                setState(() {
                                    this.widget.register.education = newValueSelected;
                                });
                                provider.setValidatePersonalData(this.widget.register);
                            },
                            validator: (value) {
                                if (value == null) {
                                    return 'Education cannot be empty';
                                }
                            }, 
                        );
                    },
                )
            ],
        );
    }

    Widget fieldDateOfBirth() {
        if (this.widget.register.dateOfBirth != null && this.widget.register.dateOfBirth.isNotEmpty) {
            setState(() {
                this.dateOfBirthController.text = this.widget.register.dateOfBirth;
            });
        }

        return Consumer<RegisterProvider>(
            builder: (context, provider, child) {
                return FormFieldCustome(
                    textLabel: 'Date Of Birth ',
                    textFormField: TextFormField(
                        controller: this.dateOfBirthController,
                        decoration: InputDecoration(
                            hintText: 'Date Of Birth',
                            errorText: provider.dateOfBirth.error,
                        ),
                        readOnly: true,
                        onTap: () {
                            datePickerShow(provider);
                        },
                        validator: (value) {
                            if (value.isEmpty) {
                                return 'Date Of Birth cannot be empty';
                            }
                        }, 
                    )
                );
            },
        );
    }

    void datePickerShow(RegisterProvider provider) async {
        DateTime dateTime = await showDatePicker(
            useRootNavigator: false,
            context: context,
            firstDate: DateTime(1900),
            initialDate: DateTime.now(),
            lastDate: DateTime(2100)
        );

        if (dateTime != null) {
            this.dateOfBirthController.text = DateFormat('dd-MM-yyyy').format(dateTime);
            provider.setDateOfBirth(this.dateOfBirthController.text);
            provider.setValidatePersonalData(this.widget.register); 
        }
    }
}