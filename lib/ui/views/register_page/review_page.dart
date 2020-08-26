import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_tunaiku/models/register.dart';
import 'package:register_tunaiku/provider/register_provider.dart';
import 'package:register_tunaiku/ui/widgets/form_field_custome.dart';

class ReviewPage extends StatefulWidget {
    String titlePage;
    Register register;
    PageController pageController;

    ReviewPage({
        @required this.titlePage,
        @required this.register,
        @required this.pageController
    });

    @override
    _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
    @override
    Widget build(BuildContext context) {
        return Column(
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
                                        fieldDomicile(),
                                        SizedBox(height: 10),
                                        fieldHousingType(),
                                        SizedBox(height: 20),
                                        fieldNo(),
                                        SizedBox(height: 25),
                                        fieldProvince(),
                                        SizedBox(height: 25),
                                    ],
                                ),
                            )
                        ),
                    )
                ),
                Container(
                        height: 80,
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                            children: <Widget>[
                                Expanded(
                                    child: Consumer<RegisterProvider>(
                                        builder: (context, provider, child) {
                                            return Container(
                                                height: 80,
                                                child: FlatButton(
                                                    color: Color(0xFF5AB11A),
                                                    textColor: Colors.white,
                                                    padding: EdgeInsets.all(8.0),
                                                    splashColor: Colors.greenAccent,
                                                    onPressed: () {
                                                        this.widget.pageController.jumpToPage(1);
                                                    },
                                                    child: Text(
                                                        "Back",
                                                        style: TextStyle(fontSize: 15.0),
                                                    ),
                                                )
                                            );
                                        },
                                    ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Consumer<RegisterProvider>(
                                        builder: (context, provider, child) {
                                            return Container(
                                                height: 80,
                                                child: FlatButton(
                                                    color: Color(0xFF5AB11A),
                                                    textColor: Colors.white,
                                                    disabledColor: Colors.grey,
                                                    disabledTextColor: Colors.white,
                                                    padding: EdgeInsets.all(8.0),
                                                    splashColor: Colors.greenAccent,
                                                    onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                                return AlertDialog(
                                                                    title: Text("Registration Finish"),
                                                                    content: Text("Thank You For Registering"),
                                                                    actions: [
                                                                        FlatButton(
                                                                            child: Text("OK"),
                                                                            onPressed: () {
                                                                                Navigator.pop(context);
                                                                            },
                                                                        )
                                                                    ],
                                                                );;
                                                            },
                                                        );
                                                    },
                                                    child: Text(
                                                        "Finish",
                                                        style: TextStyle(fontSize: 15.0),
                                                    ),
                                                )
                                            );
                                        },
                                    )
                                )
                            ],
                        )
                    )
            ],
        );
    }

    Widget fieldNationalID() {
        return FormFieldCustome(
            textLabel: 'National ID ',
            textFormField: TextFormField(
                initialValue: this.widget.register.nationalID.toString(),
                maxLength: 16,
                readOnly: true,
                keyboardType: TextInputType.number,
            )
        );
    }

    Widget fieldFullName() {
        return FormFieldCustome(
            textLabel: 'Fullname ',
            textFormField: TextFormField(
                initialValue: this.widget.register.fullName,
                maxLength: 10,
                readOnly: true,
            )
        );
    }

    Widget fieldBankAccount() {
        return FormFieldCustome(
            textLabel: 'Bank Account ',
            textFormField: TextFormField(
                initialValue: this.widget.register.bankAccount.toString(),
                maxLength: 8,
                keyboardType: TextInputType.number,
                readOnly: true,
            )
        );
    }

    Widget fieldEducation() {
        return FormFieldCustome(
            textLabel: 'Education ',
            textFormField: TextFormField(
                initialValue: this.widget.register.education,
                readOnly: true,
            )
        );
    }

    Widget fieldDateOfBirth() {
        return FormFieldCustome(
            textLabel: 'Date Of Birth ',
            textFormField: TextFormField(
                initialValue: this.widget.register.dateOfBirth,
                readOnly: true,
            )
        );
    }

    Widget fieldDomicile() {
        return FormFieldCustome(
            textLabel: 'Domicile Address ',
            textFormField: TextFormField(
                initialValue: this.widget.register.domicileAddress,
                maxLength: 100,
                maxLines: 3,
                readOnly: true,
            )
        );
    }

    Widget fieldHousingType() {
        return FormFieldCustome(
            textLabel: 'Housing Type ',
            textFormField: TextFormField(
                initialValue: this.widget.register.housingType,
                readOnly: true,
            )
        );
    }

    Widget fieldNo() {
        return FormFieldCustome(
            textLabel: 'No Address ',
            textFormField: TextFormField(
                readOnly: true,
                initialValue: this.widget.register.noAddress,
            )
        );
    }

    Widget fieldProvince() {
        return FormFieldCustome(
            textLabel: 'Province ',
            textFormField: TextFormField(
                readOnly: true,
                initialValue: this.widget.register.idProvince,
            )
        );
    }
}