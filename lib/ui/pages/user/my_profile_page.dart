import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/user/user_response_model.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';
import 'package:tomatebnb/Utils/customwidget.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    getdarkmodepreviousstate();
    getMode();
    super.initState();
    context.read<UserBloc>().add(UserGetByIdEvent());
  }

  late ColorNotifire notifire;
  late bool? isAnfitrion = false;
  String profilePhoto = "";
  String profileName = "";
  String profileEmail = "";
  int profileId = 0;
  final String _imgsUrl = Environment.UrlImg;
  UserResponseModel user = UserResponseModel();

  void getMode() async {
    final prefs = await SharedPreferences.getInstance();
    isAnfitrion = prefs.getBool("setIsAnfitrion");
    profilePhoto = prefs.getString("profilePhoto") ?? "";
    profileName = prefs.getString("name") ?? "";
    profileEmail = prefs.getString("email") ?? "";
    profileId = prefs.getInt("userId") ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: notifire.getbgcolor,
        leading: BackButton(color: notifire.getwhiteblackcolor),
        title: Text(
          "Mi Perfil",
          style: TextStyle(
              color: notifire.getwhiteblackcolor, fontFamily: "Gilroy Bold"),
        ),
      ),
      backgroundColor: notifire.getbgcolor,
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
            if(state is UserGetByIdError){
               ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(state.message)));
            }

        },
        builder: (context, state) {
          
          if(state is UserGetByIdSuccess){
            user = state.responseUser;
                  return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        color: notifire.getbgcolor,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 25,
                              left: 30,
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: profilePhoto == ""
                                    ? AssetImage("assets/images/image.png")
                                    : NetworkImage('$_imgsUrl/users/$profilePhoto'),
                                // child: Image.asset("assets/images/person1.jpeg"),
                              ),
                            ),
                            Positioned(
                              top: 115,
                              // bottom: 20,
                              right: 25,
                              // left: 20,
                              child: GestureDetector(
                                onTap: () {
                                  print("object gesture detecteando");
                                },
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: WhiteColor,
                                  child: CircleAvatar(
                                    radius: 25,
                                    child: Image.asset(
                                      'assets/images/camera.png',
                                      height: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "Nombre",
                              style: TextStyle(
                                fontSize: 16,
                                color: notifire.getwhiteblackcolor,
                                fontFamily: "Gilroy Bold",
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.012),
                          textfield(
                              feildcolor: notifire.getdarkmodecolor,
                              hintcolor: notifire.getgreycolor,
                              text: "",
                              prefix: Image.asset("assets/images/profile.png",
                                  height: 25, color: notifire.getgreycolor),
                              suffix: null),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.025),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "Apellidos",
                              style: TextStyle(
                                fontSize: 16,
                                color: notifire.getwhiteblackcolor,
                                fontFamily: "Gilroy Bold",
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.012),
                          textfield(
                              feildcolor: notifire.getdarkmodecolor,
                              hintcolor: notifire.getgreycolor,
                              text: "",
                              prefix: Image.asset("assets/images/profile.png",
                                  height: 25, color: notifire.getgreycolor),
                              suffix: null),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.025),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 16,
                                color: notifire.getwhiteblackcolor,
                                fontFamily: "Gilroy Bold",
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.012),
                          textfield(
                              feildcolor: notifire.getdarkmodecolor,
                              hintcolor: notifire.getgreycolor,
                              text: "",
                              prefix: Image.asset("assets/images/profile.png",
                                  height: 25, color: notifire.getgreycolor),
                              suffix: null),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.025),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "Telefono",
                              style: TextStyle(
                                fontSize: 16,
                                color: notifire.getwhiteblackcolor,
                                fontFamily: "Gilroy Bold",
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.012),
                          textfield(
                              feildcolor: notifire.getdarkmodecolor,
                              hintcolor: notifire.getgreycolor,
                              text: "",
                              prefix: Image.asset("assets/images/profile.png",
                                height: 25, color: notifire.getgreycolor),
                              suffix: null),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.025),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "Biografia",
                              style: TextStyle(
                                fontSize: 16,
                                color: notifire.getwhiteblackcolor,
                                fontFamily: "Gilroy Bold",
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.012),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16), color: WhiteColor),
                            child: TextField(
                              // controller: controller,
                              minLines: 3,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Me dedico a......',
                                labelStyle: const TextStyle(color: Colors.white),
                                hintStyle: TextStyle(color: notifire.getgreycolor, fontFamily: "Gilroy Medium"),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  child: Image.asset("assets/images/profile.png",
                                    height: 25, color: notifire.getgreycolor),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: null,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: greyColor,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.025),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "Tipo de Documento",
                              style: TextStyle(
                                fontSize: 16,
                                color: notifire.getwhiteblackcolor,
                                fontFamily: "Gilroy Bold",
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.012),
                          textfield(
                              feildcolor: notifire.getdarkmodecolor,
                              hintcolor: notifire.getgreycolor,
                              text: "",
                              prefix: Image.asset("assets/images/profile.png",
                                  height: 25, color: notifire.getgreycolor),
                              suffix: null),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.025),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "Número de documento",
                              style: TextStyle(
                                fontSize: 16,
                                color: notifire.getwhiteblackcolor,
                                fontFamily: "Gilroy Bold",
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.012),
                          textfield(
                              feildcolor: notifire.getdarkmodecolor,
                              hintcolor: notifire.getgreycolor,
                              text: "",
                              prefix: Image.asset("assets/images/profile.png",
                                  height: 25, color: notifire.getgreycolor),
                              suffix: null),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.025),
                          AppButton(
                              buttontext: "Guardar Cambios",
                              onclick: () {
                                // Navigator.pop(context);
                              },
                              context: context),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Center(
                            child: InkWell(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => const newPassword(),
                                //   ),
                                // );
                              },
                              child: Text(
                                "Cambiar Contraseña?",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Darkblue,
                                  fontFamily: "Gilroy Bold",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                      /* SizedBox(height: MediaQuery.of(context).size.height * 0.22),*/
                    ],
                  ),
                ),
              );
            
          }else if(state is UserGetByIdLoading){
            return Center(child: CircularProgressIndicator(),);
          }else if(state is UserGetByIdError){
            return (Center(child:Text(state.message)));
          }else {
            return Center(child:Text('Algo salió mal'));
          }
        }
      ),
     
      resizeToAvoidBottomInset: false,
    );
  }

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
}
