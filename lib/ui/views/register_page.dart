import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_tunaiku/models/register.dart';
import 'package:register_tunaiku/provider/register_provider.dart';
import 'package:register_tunaiku/ui/views/register_page/ktp_page.dart';
import 'package:register_tunaiku/ui/views/register_page/personal_data_page.dart';
import 'package:register_tunaiku/ui/views/register_page/review_page.dart';

class RegisterPage extends StatefulWidget {
    @override
    _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    PageController _controller = PageController();
    Register register = new Register();
    int indexPage = 0;

    setIndexPage(int index) {
        setState(() {
            indexPage = index;
        });
    }

    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider<RegisterProvider>(
            create: (context) => RegisterProvider(),
            child: Scaffold(
                appBar: AppBar(
                    title: Text('Registration Form'),
                    centerTitle: true,
                ),
                body: pageView(),
            )
        );
    }

    Widget pageView() {
        return PageView(
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
                setIndexPage(value);
            },
            controller: _controller,
            children: <Widget>[
                PersonalDataPage(
                    titlePage: 'Personal Data (1/3)',
                    register: this.register,
                    pageController: this._controller
                ),
                KtpPage(
                    titlePage: 'Address ID Card Data (2/3)',
                    register: this.register,
                    pageController: this._controller
                ),
                ReviewPage(
                    titlePage: 'Review Registration (3/3)',
                    register: this.register,
                    pageController: this._controller
                )
            ],
        );
    }
}