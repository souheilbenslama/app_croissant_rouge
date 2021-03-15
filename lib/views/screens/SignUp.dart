//KHALIL
import 'package:app_croissant_rouge/views/screens/SignIn.dart';
import 'package:flutter/material.dart';

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
          'Nom Complet :',
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
            validator: (String value) {
              if (value.isEmpty) {
                return 'Champ Obligatoire !';
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
              hintText: 'Saisir votre nom',
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
          'Email :',
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
            validator: (String value) {
              if (value.isEmpty) {
                return 'Champ Obligatoire !';
              }
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return 'Saisir un email valide';
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
              hintText: 'Saisir votre email',
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
          'N° CIN :',
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
            validator: (String value) {
              if (value.isEmpty) {
                return 'Champ Obligatoire !';
              }
              if (!RegExp("^[0-9]*").hasMatch(value)) {
                return 'Saisir un numero valide';
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
              hintText: 'Saisir votre numero de CIN',
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
          'Telephone :',
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
            validator: (String value) {
              if (value.isEmpty) {
                return 'Champ Obligatoire !';
              }
              if (!RegExp("^[0-9]*").hasMatch(value)) {
                return 'Saisir un numero valide';
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
              hintText: 'Saisir votre numero de telephone',
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
          'Mot de passe :',
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
              if (val.isEmpty) return 'Champ Obligatoire !';
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
              hintText: 'Saisir votre mot de passe',
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
              if (val.isEmpty) return 'Champ Obligatoire !';
              if (val != _pass.text)
                return 'Les mots de passe ne sont pas identiques';
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
              hintText: 'Confirmer votre mot de passe',
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
          'Adresse :',
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
            validator: (String value) {
              if (value.isEmpty) {
                return 'Champ Obligatoire !';
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
              hintText: 'Saisir votre adresse',
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
                        'S\'inscrire',
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
                            'Je suis un secouriste',
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
                            onPressed: () {
                              _form.currentState.validate();
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            color: Colors.redAccent[700],
                            child: Text(
                              'S\'inscrire',
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
                                text: "Vous avez déjà un compte? ",
                                style: TextStyle(
                                    color: Colors.redAccent[700],
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w400)),
                            TextSpan(
                                text: "Se connecter",
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
