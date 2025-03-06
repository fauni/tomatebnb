import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/user/user_request_model.dart';
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
  UserRequestModel reqUser = UserRequestModel();
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _biographyController = TextEditingController();
  final _profilePhotoController = TextEditingController();
  final _documentNumberController = TextEditingController();
  final _documentTypeController = TextEditingController();
  final _documentPhotoFrontController = TextEditingController();
  final _documentPhotoBackController = TextEditingController();
  final _confirmPhotoController = TextEditingController();
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
      body: BlocConsumer<UserBloc, UserState>(listener: (context, state) {
        if (state is UserGetByIdError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is UserGetByIdSuccess) {
          user = state.responseUser;
          _nameController.text = user.name ?? "";
          _lastnameController.text = user.lastname ?? "";
          _emailController.text = user.email ?? "";
          _phoneController.text = user.phone ?? "";
          _biographyController.text = user.biography ?? "";
          _profilePhotoController.text = user.profilePhoto ?? "";
          _documentNumberController.text = user.documentNumber ?? "";
          _documentTypeController.text = user.documentType ?? "";
          _documentPhotoFrontController.text = user.documentPhotoFront ?? "";
          _documentPhotoBackController.text = user.documentPhotoBack ?? "";
          _confirmPhotoController.text = user.confirmPhoto ?? "";
        }
      }, builder: (context, state) {
        if (state is UserGetByIdLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserGetByIdError) {
          return (Center(child: Text(state.message)));
        } else {
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

                        BlocConsumer<UserBloc, UserState>(
                          listener: (context, state) {
                            if(state is UserPhotoUpdateSuccess){
                              user = state.responseUserPhoto;
                              profilePhoto = user.profilePhoto??"";
                              setState(() {
                              });
                            }
                            if(state is UserPhotoUpdateError){
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ));
                            }
                          },
                          builder: (context, state) {
                            if( state is UserPhotoUpdateLoading ){
                              return Center(child:CircularProgressIndicator());
                            }
                            return Positioned(
                              top: 115,
                              // bottom: 20,
                              right: 25,
                              // left: 20,
                              child: GestureDetector(
                                onTap: () {
                                  bottomsheet("profile_photo");
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
                            );
                          },
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
                          controller: _nameController,
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
                          controller: _lastnameController,
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
                          controller: _emailController,
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
                          controller: _phoneController,
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
                            borderRadius: BorderRadius.circular(16),
                            color: WhiteColor),
                        child: TextField(
                          controller: _biographyController,
                          minLines: 3,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Me dedico a......',
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: TextStyle(
                                color: notifire.getgreycolor,
                                fontFamily: "Gilroy Medium"),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
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
                          controller: _documentTypeController,
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
                          controller: _documentNumberController,
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
                          "Fotografia frontal del documento",
                          style: TextStyle(
                            fontSize: 16,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold",
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012),
                       
                       Stack(
                         children: [
                          user.documentPhotoFront!= null && user.documentPhotoFront!=""
                       ? FadeInImage.assetNetwork(
                                image: '$_imgsUrl/users/${user.documentPhotoFront}',
                                placeholder: "assets/images/load.gif",
                              )
                              :Image.asset("assets/images/image.png"),
                          BlocConsumer<UserBloc, UserState>(
                          listener: (context, state) {
                            if(state is UserPhotoUpdateSuccess){
                              user = state.responseUserPhoto;
                              profilePhoto = user.profilePhoto??"";
                              setState(() {
                              });
                            }
                            if(state is UserPhotoUpdateError){
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ));
                            }
                          },
                          builder: (context, state) {
                            if( state is UserPhotoUpdateLoading ){
                              return Center(child:CircularProgressIndicator());
                            }
                            return GestureDetector(
                                onTap: () {
                                  bottomsheet("document_photo_front");
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
                              );
                          },
                        ),
                      
                      
                         ],
                       ),
                       SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                       Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          "Fotografia trasera del documento",
                          style: TextStyle(
                            fontSize: 16,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold",
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012),
                       
                       Stack(
                         children: [
                          user.documentPhotoBack!= null && user.documentPhotoBack!=""
                       ? FadeInImage.assetNetwork(
                                image: '$_imgsUrl/users/${user.documentPhotoBack}',
                                placeholder: "assets/images/load.gif",
                              )
                              :Image.asset("assets/images/image.png"),
                          BlocConsumer<UserBloc, UserState>(
                          listener: (context, state) {
                            if(state is UserPhotoUpdateSuccess){
                              user = state.responseUserPhoto;
                              profilePhoto = user.profilePhoto??"";
                              setState(() {
                              });
                            }
                            if(state is UserPhotoUpdateError){
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ));
                            }
                          },
                          builder: (context, state) {
                            if( state is UserPhotoUpdateLoading ){
                              return Center(child:CircularProgressIndicator());
                            }
                            return GestureDetector(
                                onTap: () {
                                  bottomsheet("document_photo_back");
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
                              );
                          },
                        ),
                      
                      
                         ],
                       ),
                         SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                       Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          "Tómate una fotografia con tu documento ",
                          style: TextStyle(
                            fontSize: 16,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold",
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012),
                       
                       Stack(
                         children: [
                          user.confirmPhoto!= null && user.confirmPhoto!=""
                       ? FadeInImage.assetNetwork(
                                image: '$_imgsUrl/users/${user.confirmPhoto}',
                                placeholder: "assets/images/load.gif",
                              )
                              :Image.asset("assets/images/image.png"),
                          BlocConsumer<UserBloc, UserState>(
                          listener: (context, state) {
                            if(state is UserPhotoUpdateSuccess){
                              user = state.responseUserPhoto;
                              profilePhoto = user.profilePhoto??"";
                              setState(() {
                              });
                            }
                            if(state is UserPhotoUpdateError){
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ));
                            }
                          },
                          builder: (context, state) {
                            if( state is UserPhotoUpdateLoading ){
                              return Center(child:CircularProgressIndicator());
                            }
                            return GestureDetector(
                                onTap: () {
                                  bottomsheet("confirm_photo");
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
                              );
                          },
                        ),
                      
                      
                         ],
                       ),
                         


                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012),
                      
                      BlocConsumer<UserBloc, UserState>(
                        listener: (context, state) {
                          if (state is UserUpdateError) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ));
                          }
                          if (state is UserUpdateSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Datos actualizados"),
                            ));
                          }
                        },
                        builder: (context, state) {
                          if (state is UserUpdateLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          

                          return AppButton(
                              buttontext: "Guardar Cambios",
                              onclick: () {
                                // Navigator.pop(context);
                                reqUser.name = _nameController.text;
                                reqUser.lastname = _lastnameController.text;
                                reqUser.email = _emailController.text;
                                reqUser.phone = _phoneController.text;
                                reqUser.biography = _biographyController.text;
                                reqUser.profilePhoto =
                                    _profilePhotoController.text;
                                reqUser.documentNumber =
                                    _documentNumberController.text;
                                reqUser.documentType =
                                    _documentTypeController.text;
                                reqUser.documentPhotoFront =
                                    _documentPhotoFrontController.text;
                                reqUser.documentPhotoBack =
                                    _documentPhotoBackController.text;
                                reqUser.confirmPhoto =
                                    _confirmPhotoController.text;
                                reqUser.recordDate = user.recordDate;
                                reqUser.verified = user.verified;
                                reqUser.status = user.status;
                                context
                                    .read<UserBloc>()
                                    .add(UserUpdateEvent(reqUser));
                              },
                              context: context);
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2),
                      // Center(
                      //   child: InkWell(
                      //     onTap: () {
                      //       // Navigator.of(context).push(
                      //       //   MaterialPageRoute(
                      //       //     builder: (context) => const newPassword(),
                      //       //   ),
                      //       // );
                      //     },
                      //     child: Text(
                      //       "Cambiar Contraseña?",
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         color: Darkblue,
                      //         fontFamily: "Gilroy Bold",
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 15),
                    ],
                  ),
                  /* SizedBox(height: MediaQuery.of(context).size.height * 0.22),*/
                ],
              ),
            ),
          );
        }
      }),
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

  bottomsheet(String column) {
    return showModalBottomSheet(
        backgroundColor: notifire.getbgcolor,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();

                            context
                                .read<UserBloc>()
                                .add(UserPhotoUpdateEvent(false, column));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: WhiteColor,
                                borderRadius: BorderRadius.circular(5)),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Desde Galeria",
                                style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(color: Theme.of(context).colorScheme.primary),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            context
                                .read<UserBloc>()
                                .add(UserPhotoUpdateEvent(true, column));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(5)),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Desde Cámara",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: WhiteColor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
