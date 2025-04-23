import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

  changeMode() async {
    final prefs = await SharedPreferences.getInstance();
    if(isAnfitrion == null || isAnfitrion == false){
      prefs.setBool("setIsAnfitrion", true);
      // ignore: use_build_context_synchronously
      context.push('/menu-anfitrion');
    } else {
      prefs.setBool("setIsAnfitrion", false);
      // ignore: use_build_context_synchronously
      context.push('/menu-viajero');
    }
  }
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isAnfitrion != null && isAnfitrion == true ? 
        FloatingActionButton.extended(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () => changeMode(), 
          label: Text('Cambiar a modo viajero'),
          icon: Icon(Icons.change_circle_outlined),
        ) 
        : FloatingActionButton.extended(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () => changeMode(), 
          label: Text('Cambiar a modo anfitrion'),
          icon: Icon(Icons.change_circle_outlined),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        automaticallyImplyLeading: false,
        title: Text("Mi Perfil",style: TextStyle(fontFamily: "Gilroy Bold"),),
        actions: [
          
          SizedBox(width: 10,)
        ],
      ),
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   leading: BackButton(color: notifire.getwhiteblackcolor),
      //   title: Text("Mi Perfil",style: TextStyle(fontFamily: "Gilroy Bold"),
      //   ),
      // ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserUpdateError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor:Theme.of(context).colorScheme.error,
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
      ),
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
                  SizedBox(
                    height: 200,
                    width: 200,
                    // color: notifire.getbgcolor,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 25,
                          left: 30,
                          child: Container(
                            width: 140, // 2 * radius
                            height: 140, // 2 * radius
                            decoration: BoxDecoration(
                              color: color.secondary.withAlpha(50),
                              shape: BoxShape.circle,
                            ),
                            child: profilePhoto == ""
                              ? Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Image.asset("assets/images/image.png"),
                                )
                              : ClipOval(
                                  child: Image.network(
                                    '$_imgsUrl/users/$profilePhoto',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          ),
                        ),

                        BlocConsumer<UserBloc, UserState>(
                          listener: (context, state) {
                            if(state is UserPhotoUpdateSuccess){
                              user = state.responseUserPhoto;
                              profilePhoto = user.profilePhoto??"";
                              setState(() {});
                            }
                            if(state is UserPhotoUpdateError){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message),backgroundColor:Theme.of(context).colorScheme.error,)
                              );
                            }
                          },
                          builder: (context, state) {
                            if( state is UserPhotoUpdateLoading ){
                              return Center(child:CircularProgressIndicator());
                            }
                            return Positioned(
                              top: 115, right: 25,
                              child: GestureDetector(
                                onTap: () =>bottomsheet("profile_photo"),
                                child: CircleAvatar(
                                  backgroundColor: color.tertiary,
                                  radius: 25,
                                  child: Image.asset('assets/images/camera.png',height: 25,),
                                ),
                              ),
                            );
                          },
                        ),
                      
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: (){context.push("/cambiar_password");}, 
                            child: Text("Cambiar Contraseña")
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text("Nombre",style: TextStyle(fontSize: 12,fontFamily: "Gilroy Bold"),),
                      ),
                      textfield(
                        controller: _nameController,
                        text: "",
                        prefix: Image.asset("assets/images/profile.png", height: 25),
                        suffix: null
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text("Apellidos",style: TextStyle(fontSize: 12,fontFamily: "Gilroy Bold"),),
                      ),
                      textfield(
                        controller: _lastnameController,
                        text: "",
                        prefix: Image.asset("assets/images/profile.png",height: 25),
                        suffix: null
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text("Email",style: TextStyle(fontSize: 12,fontFamily: "Gilroy Bold"),),
                      ),
                      textfield(
                        controller: _emailController,
                        text: "",
                        prefix: Image.asset("assets/images/profile.png",height: 25),
                        suffix: null
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text("Telefono",style: TextStyle(fontSize: 12,fontFamily: "Gilroy Bold"),),
                      ),
                      textfield(
                        controller: _phoneController,
                        text: "",
                        prefix: Image.asset("assets/images/profile.png",height: 25),
                        suffix: null
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text("Biografia", style: TextStyle(fontSize: 12,fontFamily: "Gilroy Bold"),),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          controller: _biographyController,
                          minLines: 2,
                          maxLines: 5,
                          maxLength: 100,
                          decoration: InputDecoration(
                            hintText: 'Me dedico a......',
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: color.secondary,fontFamily: "Gilroy Medium"),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              child: Image.asset("assets/images/profile.png", height: 25),
                            ),
                            suffixIcon: Padding(padding: const EdgeInsets.all(6),child: null,),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: greyColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text("Tipo de Documento",style: TextStyle(fontSize: 12,fontFamily: "Gilroy Bold"),),
                      ),
                      textfield(
                        controller: _documentTypeController,
                        text: "",
                        prefix: Image.asset("assets/images/profile.png",height: 25),
                        suffix: null
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text("Número de documento", style: TextStyle(fontSize: 12,fontFamily: "Gilroy Bold"),),
                      ),
                      textfield(
                        controller: _documentNumberController,
                        text: "",
                        prefix: Image.asset("assets/images/profile.png",height: 25),
                        suffix: null
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          "Fotografia frontal del documento",
                          style: TextStyle(fontSize: 12,fontFamily: "Gilroy Bold"),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                      Stack(
                        children: [
                          user.documentPhotoFront!= null && user.documentPhotoFront!=""
                          ? FadeInImage.assetNetwork(
                              image: '$_imgsUrl/users/${user.documentPhotoFront}',
                              placeholder: "assets/images/load.gif",
                            )
                          : Center(child: Image.asset("assets/images/picture.png", height: 100,)),
                          BlocConsumer<UserBloc, UserState>(
                          listener: (context, state) {
                            if(state is UserPhotoUpdateSuccess){
                              user = state.responseUserPhoto;
                              _documentPhotoFrontController.text = user.documentPhotoFront??"";
                              setState(() {});
                            }
                            if(state is UserPhotoUpdateError){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message),
                              backgroundColor: color.error,
                              ));
                            }
                          },
                          builder: (context, state) {
                            if( state is UserPhotoUpdateLoading ){return Center(child:CircularProgressIndicator());}
                            return GestureDetector(
                                onTap: () { bottomsheet("document_photo_front");},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: color.tertiary.withAlpha(150),
                                    child: Image.asset('assets/images/camera.png',height: 25,),
                                  ),
                                ),
                              );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text("Fotografia trasera del documento",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Gilroy Bold",
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                       
                    Stack(
                      children: [
                        user.documentPhotoBack!= null && user.documentPhotoBack!=""
                        ? FadeInImage.assetNetwork(
                          image: '$_imgsUrl/users/${user.documentPhotoBack}',
                          placeholder: "assets/images/load.gif",
                        )
                        : Center(child: Image.asset("assets/images/picture.png", height: 100,)),
                          BlocConsumer<UserBloc, UserState>(
                          listener: (context, state) {
                            if(state is UserPhotoUpdateSuccess){
                              user = state.responseUserPhoto;
                              _documentPhotoBackController.text = user.documentPhotoBack??"";
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: color.tertiary.withAlpha(150),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        "Tómate una fotografia con tu documento ",
                        style: TextStyle(fontSize: 12,fontFamily: "Gilroy Bold",),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                      Stack(
                        children: [
                          user.confirmPhoto!= null && user.confirmPhoto!=""
                          ? FadeInImage.assetNetwork(
                              image: '$_imgsUrl/users/${user.confirmPhoto}',
                              placeholder: "assets/images/load.gif",
                            )
                          : Center(child: Image.asset("assets/images/image.png", height: 100,)),
                          BlocConsumer<UserBloc, UserState>(
                          listener: (context, state) {
                            if(state is UserPhotoUpdateSuccess){
                              user = state.responseUserPhoto;
                              _confirmPhotoController.text = user.confirmPhoto??"";
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: color.tertiary.withAlpha(150),
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
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                    //   BlocConsumer<UserBloc, UserState>(
                    //     listener: (context, state) {
                    //       if (state is UserUpdateError) {
                    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //           content: Text(state.message),
                    //           backgroundColor:Theme.of(context).colorScheme.error,
                    //         ));
                    //       }
                    //       if (state is UserUpdateSuccess) {
                    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //           content: Text("Datos actualizados"),
                    //         ));
                    //       }
                    //     },
                    //     builder: (context, state) {
                    //       if (state is UserUpdateLoading) {
                    //         return Center(child: CircularProgressIndicator());
                    //       }
                          

                    //       return AppButton(
                    //           buttontext: "Guardar Cambios",
                    //           onclick: () {
                    //             // Navigator.pop(context);
                    //             reqUser.name = _nameController.text;
                    //             reqUser.lastname = _lastnameController.text;
                    //             reqUser.email = _emailController.text;
                    //             reqUser.phone = _phoneController.text;
                    //             reqUser.biography = _biographyController.text;
                    //             reqUser.profilePhoto =
                    //                 _profilePhotoController.text;
                    //             reqUser.documentNumber =
                    //                 _documentNumberController.text;
                    //             reqUser.documentType =
                    //                 _documentTypeController.text;
                    //             reqUser.documentPhotoFront =
                    //                 _documentPhotoFrontController.text;
                    //             reqUser.documentPhotoBack =
                    //                 _documentPhotoBackController.text;
                    //             reqUser.confirmPhoto =
                    //                 _confirmPhotoController.text;
                    //             reqUser.recordDate = user.recordDate;
                    //             reqUser.verified = user.verified;
                    //             reqUser.status = user.status;
                    //             context
                    //                 .read<UserBloc>()
                    //                 .add(UserUpdateEvent(reqUser));
                    //           },
                    //           context: context);
                    //     },
                    //   ),
                    //   SizedBox(height: MediaQuery.of(context).size.height * 0.2),  
                    ],
                  ),
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
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.20,child: Padding(
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
                          context.read<UserBloc>().add(UserPhotoUpdateEvent(false, column));
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
