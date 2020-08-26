import 'package:flutter/material.dart';

class FormFieldCustome extends StatelessWidget {
    String textLabel;
    TextFormField textFormField;

    FormFieldCustome({
        this.textLabel,
        this.textFormField,
        Key key
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                RichText(
                    text: TextSpan(
                        text: textLabel,
                        style: TextStyle(
                            color: Color(0xFF5AB11A),
                            fontWeight: FontWeight.w600
                        ),
                        children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                        ],
                    ),
                ),
                this.textFormField
            ],
        );
    }
}