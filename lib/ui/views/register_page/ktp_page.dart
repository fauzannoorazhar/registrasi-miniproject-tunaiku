import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:register_tunaiku/bloc/province_bloc.dart';
import 'package:register_tunaiku/bloc/province_event.dart';
import 'package:register_tunaiku/bloc/province_state.dart';
import 'package:register_tunaiku/data/domain/province_domain.dart';
import 'package:register_tunaiku/data/repository/province_repository.dart';
import 'package:register_tunaiku/models/province.dart';
import 'package:register_tunaiku/models/register.dart';
import 'package:register_tunaiku/provider/register_provider.dart';
import 'package:register_tunaiku/ui/widgets/form_field_custome.dart';

class KtpPage extends StatefulWidget {
    String titlePage;
    Register register;
    PageController pageController;

    KtpPage({
        @required this.titlePage,
        @required this.register,
        @required this.pageController
    });

    @override
    _KtpPageState createState() => _KtpPageState();
}

class _KtpPageState extends State<KtpPage> {
    final _formKey = GlobalKey<FormState>();
    TextEditingController domicileController = new TextEditingController();
    TextEditingController noAddressController = new TextEditingController();
    TextEditingController provinceController = new TextEditingController();

    List<String> listHousingType = [
        'Rumah',
        'Kantor',
    ];

    void setIdProvince(String value, RegisterProvider registerProvider) {
        setState(() {
            this.provinceController.text = value;
            this.widget.register.idProvince = value;
        });
        registerProvider.setValidateIDCardAddress(this.widget.register);
    }

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
                                                        this.widget.pageController.jumpToPage(0);
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
                                                    onPressed: (provider.validIDCardAddress) ? () {
                                                        if (_formKey.currentState.validate()) {
                                                            provider.countProgressInput();
                                                            //Future.delayed(const Duration(milliseconds: 1000), () {
                                                                this.widget.pageController.jumpToPage(2);
                                                                setState(() {
                                                                    this.widget.register.domicileAddress = domicileController.text;
                                                                    this.widget.register.noAddress = noAddressController.text;
                                                                });
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
                                )
                            ],
                        )
                    )
                ],
            )
        );
    }

    Widget fieldDomicile() {
        if (this.widget.register.domicileAddress != null && this.widget.register.domicileAddress.toString().isNotEmpty) {
            setState(() {
                this.domicileController.text = this.widget.register.domicileAddress.toString();
            });
        }

        return Consumer<RegisterProvider>(
            builder: (context, provider, child) {
                return FormFieldCustome(
                    textLabel: 'Domicile Address ',
                    textFormField: TextFormField(
                        controller: this.domicileController,
                        maxLength: 100,
                        maxLines: 3,
                        decoration: InputDecoration(
                            hintText: 'Input Your Domicile Address',
                            errorText: provider.domicileAddress.error
                        ),
                        onChanged: (value) {
                            provider.setDomicileAddress(value);
                            provider.setValidateIDCardAddress(this.widget.register);
                        },
                        validator: (value) {
                            if (value.isEmpty) {
                                return 'Domicile Address can not be empty';
                            }
                        }, 
                    )
                );
            },
        );
    }

    Widget fieldHousingType() {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                RichText(
                    text: TextSpan(
                        text: 'Housing Type',
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
                        return DropdownButton<String>(
                            hint: Text(
                                "Select Housing Type",
                                overflow: TextOverflow.ellipsis,
                            ),
                            value: (this.widget.register.housingType == null) ? null : this.widget.register.housingType,
                            isExpanded: true,
                            items: listHousingType.map((String valueDropdown) {
                                return DropdownMenuItem<String>(
                                    value: valueDropdown,
                                    child: Text(
                                        valueDropdown,
                                    ),
                                );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                                setState(() {
                                    this.widget.register.housingType = newValueSelected;
                                });
                                provider.setValidateIDCardAddress(this.widget.register);
                            },
                        );
                    },
                )
            ],
        );
    }

    Widget fieldNo() {
        if (this.widget.register.noAddress != null && this.widget.register.noAddress.toString().isNotEmpty) {
            setState(() {
                this.noAddressController.text = this.widget.register.noAddress.toString();
            });
        }

        return Consumer<RegisterProvider>(
            builder: (context, provider, child) {
                return FormFieldCustome(
                    textLabel: 'No Address ',
                    textFormField: TextFormField(
                        controller: this.noAddressController,
                        decoration: InputDecoration(
                            hintText: 'Input Your No Address',
                            errorText: provider.noAddress.error
                        ), 
                        onChanged: (value) {
                            provider.setNoAddress(value);
                            provider.setValidateIDCardAddress(this.widget.register);
                        },
                        validator: (value) {
                            if (value.isEmpty) {
                                return 'No Address can not be empty';
                            }
                        }, 
                    )
                );
            },
        );
    }

    Widget fieldProvince() {
        if (this.widget.register.idProvince != null && this.widget.register.idProvince.toString().isNotEmpty) {
            setState(() {
                this.provinceController.text = this.widget.register.idProvince.toString();
            });
        }

        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                RichText(
                    text: TextSpan(
                        text: 'Province',
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
                        return TextFormField(
                            controller: this.provinceController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Select Province'
                            ),
                            readOnly: true,
                            onTap: () {
                                return Navigator.push(context, MaterialPageRoute(builder: (context) => ListProvince(setIdProvince: setIdProvince, registerProvider: provider)));
                            },
                        );
                    },
                )
            ],
        );
    }
}

class ListProvince extends StatefulWidget {
    final Function setIdProvince;
    final RegisterProvider registerProvider;
    
    ListProvince({
        @required this.setIdProvince,
        @required this.registerProvider,
        Key key
    }) : super(key: key);

    @override
    _ListProvinceState createState() => _ListProvinceState();
}

class _ListProvinceState extends State<ListProvince> {
    // define bloc and domain
    ProvinceDomain _provinceDomain;
    ProvinceBloc _provinceBloc;

    @override
    void initState() { 
        super.initState();

        //  initState bloc and domain
        this._provinceDomain = new ProvinceDomain(new ProvinceRepository());
        this._provinceBloc = new ProvinceBloc(
            proviceDomain: this._provinceDomain,
            future: this._provinceDomain.getListProvince()
        );
    }

    @override
    Widget build(BuildContext context) {
        // add bloc
        this._provinceBloc.add(ProvinceListFetching());
        return Scaffold(
            appBar: AppBar(
                title: Text('Data Province'),
            ),
            body: BlocProvider(
                create: (context) => this._provinceBloc,
                child: BlocListener<ProvinceBloc, ProvinceState> (
                    bloc: this._provinceBloc,
                    listener: (BuildContext context, ProvinceState state) {
                        // if state error
                        if (state is ProvinceErrorFetch) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('${state.error}'),
                                    backgroundColor: Colors.red,
                                ),
                            );
                        }
                    },
                    child: BlocBuilder<ProvinceBloc, ProvinceState> (
                        bloc: this._provinceBloc,
                        builder: (BuildContext context, ProvinceState state) {
                            if (state is ProvinceSuccessFetch) {

                                return ListView.separated(
                                    itemCount: state.listProvince.length,
                                    separatorBuilder: (BuildContext context, int index) => Divider(),
                                    itemBuilder: (BuildContext context, int index) {
                                        Province province = state.listProvince[index];

                                        return ListTile(
                                            title: Text(province.nama),
                                            onTap: () {
                                                this.widget.setIdProvince(province.nama, this.widget.registerProvider);
                                                Navigator.pop(context);
                                            },
                                        );
                                    },
                                );
                            } else if (state is ProvinceLoadingFetch) {
                                return Center(
                                    child: CircularProgressIndicator(),
                                );
                            }
                        },
                    )
                )
            ),
        );
    }
}