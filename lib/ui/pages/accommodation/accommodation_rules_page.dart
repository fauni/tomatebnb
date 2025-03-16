import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_rule_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_rule_response_model.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/customwidget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class AccommodationRulesPage extends StatefulWidget {
  const AccommodationRulesPage({super.key});

  @override
  State<AccommodationRulesPage> createState() => _AccommodationRulesPageState();
}

class _AccommodationRulesPageState extends State<AccommodationRulesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late ColorNotifire notifire;

  int _accommodationId = 0;
  List<AccommodationRuleResponseModel> rules = [];
  List<TextEditingController> _descriptionsController = [];
  List<TextEditingController> _titlesController = [];
  final TextEditingController _newTitleController = TextEditingController();
  final TextEditingController _newDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    _accommodationId = GoRouterState.of(context).extra as int;

    context.read<AccommodationRuleBloc>()
        .add(AccommodationRuleGetByAccommodationEvent(_accommodationId));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: notifire.getbgcolor,
        leading: BackButton(color: notifire.getwhiteblackcolor),
        title: Text(
          "Reglas del Espacio",
          style: TextStyle(
              color: notifire.getwhiteblackcolor, fontFamily: "Gilroy Bold"),
        ),
        actions: [
          BlocConsumer<AccommodationRuleBloc, AccommodationRuleState>(
            listener: (context, state) {
              if (state is AccommodationRuleCreateSuccess) {
                // _descriptionsController.add(TextEditingController(text:_newDescriptionController.text));
                // _titlesController.add(TextEditingController(text:_newTitleController.text));
                // _newTitleController.text="";
                // _newDescriptionController.text="";
                // rules.add(state.responseAccommodationRule);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Regla creada'),
                    backgroundColor: Theme.of(context).colorScheme.primary));
                //  context
                // .read<AccommodationRuleBloc>()
                // .add(AccommodationRuleGetByAccommodationEvent(_accommodationId));
                context.pop();
                context.push('/rules', extra: _accommodationId);
              }
              if (state is AccommodationRuleCreateError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                    backgroundColor: Theme.of(context).colorScheme.error));
              }
            },
            builder: (context, state) {
              if (state is AccommodationRuleCreateLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Ink(
                height: 40,
                decoration: ShapeDecoration(
                    color: Colors.grey[300], shape: CircleBorder()),
                child: IconButton(
                    onPressed: () {
                      // context.push('/startad');
                      bottomsheet();
                    },
                    icon: const Icon(Icons.add)),
              );
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: notifire.getbgcolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocConsumer<AccommodationRuleBloc, AccommodationRuleState>(
                listener: (context, state) {
                  if (state is AccommodationRuleGetByAccommodationSuccess) {
                    for (var element in state.responseAccommodationRules) {
                      
                      _descriptionsController.add(
                          TextEditingController(text: element.description));
                      _titlesController
                          .add(TextEditingController(text: element.title));
                    }
                    rules = state.responseAccommodationRules;
                  }
                  if (state is AccommodationRuleGetByAccommodationError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is AccommodationRuleGetByAccommodationLoading) {
                    _descriptionsController=[];
                    _titlesController=[];
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  }
                  if (state is AccommodationRuleGetByAccommodationError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.builder(
                          itemCount: rules.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  // height: MediaQuery.of(context).size.height * 0.25,

                                  padding: const EdgeInsets.all(8),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: TextField(
                                          controller: _titlesController[index],
                                          minLines: 1,
                                          maxLines: 2,
                                          decoration: InputDecoration(
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: notifire.getgreycolor,
                                                fontFamily: "Gilroy Medium"),
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
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.012),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: WhiteColor),
                                        child: TextField(
                                          controller:
                                              _descriptionsController[index],
                                          minLines: 3,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
                                            hintStyle: TextStyle(
                                                color: notifire.getgreycolor,
                                                fontFamily: "Gilroy Medium"),
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
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                BlocConsumer<AccommodationRuleBloc, AccommodationRuleState>(
                                  listener: (context, state) {
                                    if(state is AccommodationRuleDeleteSuccess){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text("Regla eliminada"),
                                        backgroundColor: Theme.of(context).colorScheme.secondary,
                                      ));
                                      // context.pop();
                                      // context.push('/rules',extra:_accommodationId);
                                      context.read<AccommodationRuleBloc>()
                                      .add(AccommodationRuleGetByAccommodationEvent(_accommodationId));
                                      setState(() {
                                        
                                      });
                                    }
                                    if(state is AccommodationRuleDeleteError){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(state.message),
                                        backgroundColor: Theme.of(context).colorScheme.error,
                                      ));
                                    }
                                  },
                                  builder: (context, state) {
                                      if(state is AccommodationRuleDeleteLoading){
                                      return Center(child: CircularProgressIndicator(),);
                                    }
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        IconButton.filled(
                                            onPressed: () {
                                              context.read<AccommodationRuleBloc>().add(
                                              AccommodationRuleDeleteEvent(
                                                rules[index].id 
                                              ),
                                            );
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                            ))
                                      ],
                                    );
                                  },
                                ),
                              ],
                            );
                          }),
                    );
                  }
                },
              ),
              SizedBox(height: 15),
              BlocConsumer<AccommodationRuleBloc, AccommodationRuleState>(
                listener: (context, state) {
                  if (state is AccommodationRuleUpdateSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Reglas modificadas correctamente"),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ));
                  }
                  if (state is AccommodationRuleUpdateError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is AccommodationRuleUpdateLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  }
                  return AppButton(
                    context: context,
                    buttontext: "Guardar cambios",
                    onclick: () {
                      for (int i = 0; i < rules.length; i++) {
                        AccommodationRuleRequestModel requestModel =
                            AccommodationRuleRequestModel(
                          accommodationId: _accommodationId,
                          title: _titlesController[i].text,
                          description: _descriptionsController[i].text,
                        );
                        context.read<AccommodationRuleBloc>().add(
                              AccommodationRuleUpdateEvent(
                                rules[i].id ?? 0,
                                requestModel,
                              ),
                            );
                      }
                    },
                  );
                },
              ),
            ],
          ),
          /* SizedBox(height: MediaQuery.of(context).size.height * 0.22),*/
        ),
      ),
    );
  }

  bottomsheet() {
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
              height: MediaQuery.of(context).size.height * 0.90,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nueva regla",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              color: notifire.getwhiteblackcolor,
                            ))
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text(
                      "Título",
                      style: TextStyle(
                          fontSize: 16,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: notifire.getdarkmodecolor),
                      child: TextField(
                        controller: _newTitleController,
                        minLines: 1,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Regla de ....",
                          hintStyle: TextStyle(
                            // color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Gilroy Medium",
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffE2E4EA),
                              ),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                    // Divider(color: Theme.of(context).colorScheme.primary),
                    Text(
                      "Descripcíon",
                      style: TextStyle(
                          fontSize: 16,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: notifire.getdarkmodecolor),
                      child: TextField(
                        controller: _newDescriptionController,
                        minLines: 2,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "....",
                          hintStyle: TextStyle(
                            // color: Theme.of(context).colorScheme.secondary,
                            fontFamily: "Gilroy Medium",
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffE2E4EA),
                              ),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),

                    Divider(color: Theme.of(context).colorScheme.secondary),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          AccommodationRuleRequestModel request =
                              AccommodationRuleRequestModel(
                                  accommodationId: _accommodationId,
                                  description: _newDescriptionController.text,
                                  title: _newTitleController.text);
                          context
                              .read<AccommodationRuleBloc>()
                              .add(AccommodationRuleCreateEvent(request));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(12)),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Center(
                              child: Text(
                                "Guardar",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: WhiteColor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}
