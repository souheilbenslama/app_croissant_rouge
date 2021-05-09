//KHALIL
import 'package:app_croissant_rouge/services/login_service.dart';
import 'package:app_croissant_rouge/views/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

// The Server to the backend
const SERVER_IP = 'http://192.168.1.8:3000';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _cinController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _adressController = TextEditingController();

// Displaying dialogs
void displayDialog(BuildContext context, String title, String text) =>
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(title: Text(title), content: Text(text)),
    );

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _name;
  String _email;
  String _password;
  String _cin;
  String _tel;
  String _adresse;

  bool _checkbox = false;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  _buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'nom'.tr,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.redAccent[700],
            fontSize: 15.0,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.topLeft,
          height: 50.0,
          child: TextFormField(
            controller: _nameController,
            validator: (String value) {
              if (value.isEmpty) {
                return 'obligatoire'.tr;
              }
              return null;
            },
            onSaved: (String value) {
              _name = value;
            },
            style: TextStyle(
              color: Colors.grey[700],
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.red[300],
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.redAccent[700],
              ),
              hintText: 'nomHint'.tr,
              hintStyle: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'email'.tr + ' : ',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.redAccent[700],
            fontSize: 15.0,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.topLeft,
          height: 50.0,
          child: TextFormField(
            controller: _emailController,
            validator: (String value) {
              if (value.isEmpty) {
                return 'obligatoire'.tr;
              }
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return 'mailInvalide'.tr;
              }
              return null;
            },
            onSaved: (String value) {
              _email = value;
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.grey[700],
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.red[300],
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.redAccent[700],
              ),
              hintText: 'mailHint'.tr,
              hintStyle: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildCIN() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'cin'.tr,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.redAccent[700],
            fontSize: 15.0,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.topLeft,
          height: 50.0,
          child: TextFormField(
            controller: _cinController,
            validator: (String value) {
              if (value.isEmpty) {
                return 'obligatoire'.tr;
              }
              if (!RegExp("^[0-9]*").hasMatch(value)) {
                return 'numInvalide'.tr;
              }
              return null;
            },
            onSaved: (String value) {
              _cin = value;
            },
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.grey[700],
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.red[300],
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.badge,
                color: Colors.redAccent[700],
              ),
              hintText: 'cinHint'.tr,
              hintStyle: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildTel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'tel'.tr,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.redAccent[700],
            fontSize: 15.0,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.topLeft,
          height: 50.0,
          child: TextFormField(
            controller: _phoneController,
            validator: (String value) {
              if (value.isEmpty) {
                return 'obligatoire'.tr;
              }
              if (!RegExp("^[0-9]*").hasMatch(value)) {
                return 'numInvalide'.tr;
              }
              return null;
            },
            onSaved: (String value) {
              _tel = value;
            },
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.grey[700],
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.red[300],
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.redAccent[700],
              ),
              hintText: 'telHint'.tr,
              hintStyle: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'mdp'.tr,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.redAccent[700],
            fontSize: 15.0,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextFormField(
            controller: _pass,
            validator: (val) {
              if (val.isEmpty) return 'obligatoire'.tr;
              return null;
            },
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.grey[700],
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.red[300],
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.redAccent[700],
              ),
              hintText: 'mdpHint'.tr,
              hintStyle: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextFormField(
            controller: _confirmPass,
            validator: (val) {
              if (val.isEmpty) return 'obligatoire'.tr;
              if (val != _pass.text) return 'mdpNonIdentiques'.tr;
              return null;
            },
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.grey[700],
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.red[300],
              ),
              prefixIcon: Icon(Icons.lock),
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'mdpHint2'.tr,
              hintStyle: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildAdress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'adresse'.tr + ' : ',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.redAccent[700],
            fontSize: 15.0,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.topLeft,
          height: 50.0,
          child: TextFormField(
            controller: _adressController,
            validator: (String value) {
              if (value.isEmpty) {
                return 'obligatoire'.tr;
              }
              return null;
            },
            onSaved: (String value) {
              _adresse = value;
            },
            style: TextStyle(
              color: Colors.grey[700],
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.red[300],
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.add_location_alt_rounded,
                color: Colors.redAccent[700],
              ),
              hintText: 'adresseHint'.tr,
              hintStyle: TextStyle(color: Colors.grey[700]),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0xFFeeeeee),
                    Color(0xFFe9e9e9),
                    Color(0xFFe5e5e5),
                    Color(0xFFe0e0e0),
                  ],
                      stops: [
                    0.2,
                    0.4,
                    0.7,
                    0.9
                  ])),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 50.0),
                //FORM
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'sinscrire'.tr,
                        style: TextStyle(
                            color: Colors.redAccent[700],
                            fontFamily: 'OpenSans',
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CircleAvatar(
                        radius: 80.0,
                        backgroundImage: NetworkImage(
                            'https://media-exp1.licdn.com/dms/image/C4D0BAQEeQQyHaoMmrg/company-logo_200_200/0/1519889981767?e=2159024400&v=beta&t=tkf0F4V2T0xlxp0mWnLsdsaHhnWGIyiIyHkr9aMBD44'),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      _buildName(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildEmail(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPassword(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildCIN(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildAdress(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildTel(),
                      SizedBox(height: 50.0),
                      Container(
                        child: CheckboxListTile(
                          checkColor: Colors.white,
                          activeColor: Colors.black,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            'jeSuisSecouriste'.tr,
                            style: TextStyle(
                                color: Colors.redAccent[700],
                                decoration: TextDecoration.underline),
                          ),
                          value: _checkbox,
                          onChanged: (value) {
                            setState(() {
                              _checkbox = !_checkbox;
                            });
                          },
                        ),
                      ),
                      //SIGNUP Button
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 25.0),
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () async {
                              _form.currentState.validate();
                              var email = _emailController.text;
                              var password = _pass.text;
                              var name = _nameController.text;
                              var cin = _cinController.text;
                              var phone = _phoneController.text;
                              var address = _adressController.text;

                              if (name.length < 4)
                                displayDialog(
                                    context, "erreur".tr, "errNom".tr);
                              else if (password.length < 4)
                                displayDialog(
                                    context, "erreur".tr, "errMdp".tr);
                              else {
                                var res = await LoginServiceImp().attemptSignUp(
                                    email,
                                    password,
                                    name,
                                    cin,
                                    phone,
                                    address,
                                    _checkbox);
                                if (res == 200) {
                                  displayDialog(context, "succes".tr,
                                      "secouristeCree".tr);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignIn()));
                                } else if (res == 404)
                                  displayDialog(
                                      context, "nomExiste".tr, "nomExiste2".tr);
                                else if (res == 404)
                                  displayDialog(context, "Verifdonné".tr,
                                      "Verifdonné2".tr);
                                else {
                                  print(res);
                                  displayDialog(
                                      context, "erreur".tr, "errInconnue".tr);
                                }
                              }
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            color: Colors.redAccent[700],
                            child: Text(
                              'sinscrire'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          )),
                      //SIGNIN
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "vousAvez".tr,
                                style: TextStyle(
                                    color: Colors.redAccent[700],
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w400)),
                            TextSpan(
                                text: "seConnecter".tr,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.redAccent[700],
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold))
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
