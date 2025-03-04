import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    getdarkmodepreviousstate();
    getMode();
    super.initState();
  }

  late ColorNotifire notifire;
  late bool? isAnfitrion = false;
  String profilePhoto="";
  String profileName ="";
  String profileEmail ="";
  final String _imgsUrl = Environment.UrlImg;
  
  
  void getMode() async {
    final prefs = await SharedPreferences.getInstance();
    isAnfitrion = prefs.getBool("setIsAnfitrion");
    profilePhoto = prefs.getString("profilePhoto")??"";
    profileName = prefs.getString("name")??"";
    profileEmail = prefs.getString("email")??"";
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return  Scaffold(
      backgroundColor: notifire.getbgcolor,
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
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 18,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    InkWell(
                        onTap: () {
                          context.push("/my_profile");
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const Settings()));
                        },
                        child: CircleAvatar(
                            backgroundColor: notifire.getdarkmodecolor,
                            child: Image.asset(
                              "assets/images/setting.png",
                              height: 25,
                              color: notifire.getwhiteblackcolor,
                            ))),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: WhiteColor,
                        backgroundImage:
                        profilePhoto == ""
                            ?AssetImage("assets/images/image.png")
                            :NetworkImage('$_imgsUrl/users/$profilePhoto')
                      ),
                      const SizedBox(height: 20),
                      Text(
                        profileName,
                        style: TextStyle(
                            fontSize: 16,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold"),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        profileEmail,
                        style: TextStyle(
                            fontSize: 16,
                            color: notifire.getgreycolor,
                            fontFamily: "Gilroy Medium"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //       color: notifire.getdarkmodecolor),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 10, vertical: 10),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Transaction(text1: "26", text2: "Transaction"),
                //         Transaction(text1: "12", text2: "Review"),
                //         Transaction(text1: "4", text2: "Bookings"),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Option",
                      style: TextStyle(
                          fontSize: 18,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02),
                    AccountSetting(
                        image: "assets/images/heart.png",
                        text: "My Favourite",
                        icon: Icons.keyboard_arrow_right,
                        onclick: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const Favourite()));
                        },
                        boxcolor: notifire.getdarkmodecolor,
                        iconcolor: notifire.getwhiteblackcolor,
                        ImageColor: notifire.getwhiteblackcolor,
                        TextColor: notifire.getwhiteblackcolor),
                    AccountSetting(
                        image: "assets/images/clock.png",
                        text: "Transaction",
                        icon: Icons.keyboard_arrow_right,
                        onclick: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) =>
                          //         const TransactionHistory()));
                        },
                        boxcolor: notifire.getdarkmodecolor,
                        iconcolor: notifire.getwhiteblackcolor,
                        ImageColor: notifire.getwhiteblackcolor,
                        TextColor: notifire.getwhiteblackcolor),
                    AccountSetting(
                        image: "assets/images/discount.png",
                        text: "My Cupon",
                        icon: Icons.keyboard_arrow_right,
                        onclick: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const MyCupon()));
                        },
                        boxcolor: notifire.getdarkmodecolor,
                        iconcolor: notifire.getwhiteblackcolor,
                        ImageColor: notifire.getwhiteblackcolor,
                        TextColor: notifire.getwhiteblackcolor),
                    AccountSetting(
                        image: "assets/images/logout.png",
                        text: "Log Out",
                        icon: null,
                        onclick: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const loginscreen()));
                        },
                        boxcolor: notifire.getdarkmodecolor,
                        ImageColor: notifire.getredcolor,
                        TextColor: notifire.getredcolor),
                  ],
                )
              ],
            ),
          ),
        )
  
    );
  }
  AccountSetting(
    {IconData? icon,
    String? text,
    image,
    Color? TextColor,
    boxcolor,
    ImageColor,
    iconcolor,
    Function()? onclick}) {
  return InkWell(
    onTap: onclick,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: boxcolor),
      child: ListTile(
        leading: Image.asset(
          image,
          height: 25,
          color: ImageColor,
        ),
        title: Text(text!,
            style: TextStyle(
                fontSize: 15, color: TextColor, fontFamily: "Gilroy Bold")),
        trailing: Icon(icon, color: iconcolor),
      ),
    ),
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
}