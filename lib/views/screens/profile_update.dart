import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:app_croissant_rouge/services/login_service.dart';
import 'package:get/get.dart';
import 'package:app_croissant_rouge/views/screens/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUpdate extends StatefulWidget {
  final Secouriste secouriste;
  ProfileUpdate({this.secouriste});

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  String error = "";
  updateProfile(String email, String name, String cin, String phone,
      String address, String age) async {
    if (email.isEmpty || name.isEmpty || cin.isEmpty || phone.isEmpty) {
      error = "emptyfield".tr;
    }

    if (email.isEmail) {
      var res = await LoginServiceImp()
          .attempttoupdate(email, name, cin, phone, address, age);

      if (res.statusCode == 200) {
        var prefs = await SharedPreferences.getInstance();
        await prefs.remove("jwt");
        await prefs.setString("jwt", res.body);
        final decodedjwt = jsonDecode(res.body);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Profile(Secouriste.fromJson(decodedjwt))));
      } else {
        error = res.body;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller =
        TextEditingController(text: this.widget.secouriste.name);
    TextEditingController emailcontroller =
        TextEditingController(text: this.widget.secouriste.email);
    TextEditingController phonecontroller =
        TextEditingController(text: this.widget.secouriste.phone);
    TextEditingController agecontroller =
        TextEditingController(text: this.widget.secouriste.age.toString());
    TextEditingController gouvernoratcontroller =
        TextEditingController(text: this.widget.secouriste.gouvernorat);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Modifier le profil",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.redAccent[700],
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/profil.png",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.redAccent[100],
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Nom", 'nom'.tr, namecontroller),
              buildTextField("E-mail", 'email'.tr, emailcontroller),
              //buildTextField("À propos", "À propos".tr,TextEditingController(text: this.secouriste.description)),
              buildTextField("Num", 'Num'.tr, phonecontroller),
              buildTextField("Age", 'age'.tr, agecontroller),
              buildTextField(
                  "Gouvernorat", 'gouvernorat'.tr, gouvernoratcontroller),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Annuler",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      updateProfile(
                          emailcontroller.text,
                          namecontroller.text,
                          this.widget.secouriste.cin,
                          phonecontroller.text,
                          gouvernoratcontroller.text,
                          agecontroller.text);
                    },
                    color: Colors.redAccent[700],
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Enregistrer",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 24,
              color: Colors.grey[800],
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            )),
      ),
    );
  }
}
