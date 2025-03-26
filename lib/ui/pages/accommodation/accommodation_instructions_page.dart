import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_instruction_response_model.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/customwidget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class AccommodationInstructionsPage extends StatefulWidget {
  const AccommodationInstructionsPage({super.key});

  @override
  State<AccommodationInstructionsPage> createState() =>
      _AccommodationInstructionsPageState();
}

class _AccommodationInstructionsPageState
    extends State<AccommodationInstructionsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late ColorNotifire notifire;

  int _accommodationId = 0;
  List<AccommodationInstructionResponseModel> instructions = [];
  List<TextEditingController> _instructionsController = [];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    _accommodationId = GoRouterState.of(context).extra as int;

    context
        .read<AccommodationInstructionBloc>()
        .add(AccommodationInstructionGetByAccommodationEvent(_accommodationId));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: notifire.getbgcolor,
        leading: BackButton(color: notifire.getwhiteblackcolor),
        title: Text(
          "Instrucciones",
          style: TextStyle(
              color: notifire.getwhiteblackcolor, fontFamily: "Gilroy Bold"),
        ),
      ),
      backgroundColor: notifire.getbgcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocConsumer<AccommodationInstructionBloc,
                  AccommodationInstructionState>(
                listener: (context, state) {
                  if (state
                      is AccommodationInstructionGetByAccommodationSuccess) {
                    for (var element in state.responseAccommodationInstructions) {
                      _instructionsController
                          .add(TextEditingController(text: element.description));
                    }
                    instructions = state.responseAccommodationInstructions;
                  }
                  if (state is AccommodationInstructionGetByAccommodationError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ));
                  }
                },
                builder: (context, state) {
                  if (state
                      is AccommodationInstructionGetByAccommodationLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  }
                  if (state is AccommodationInstructionGetByAccommodationError) {
                    return Center(child: Text(state.message));
                  } else {
                    return ListView.builder(
                        itemCount: instructions.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            // height: MediaQuery.of(context).size.height * 0.25,
          
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Theme.of(context).colorScheme.surface,
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.secondary)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    instructions[index].title ?? "",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: notifire.getwhiteblackcolor,
                                      fontFamily: "Gilroy Bold",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.012),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: WhiteColor),
                                  child: TextField(
                                    controller: _instructionsController[index],
                                    minLines: 3,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
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
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                               
                              ],
                            ),
                          );
                        });
                  }
                },
              ),
              SizedBox(height: 15),
              BlocConsumer<AccommodationInstructionBloc, AccommodationInstructionState>(
                listener: (context, state) {
                  if(state is AccommodationInstructionUpdateSuccess){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Instrucciones guardadas correctamente"),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ));
                  }
                  if(state is AccommodationInstructionUpdateError){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ));
                  }
                },
                builder: (context, state) {
                if (state is AccommodationInstructionUpdateLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  );
                  }
                  return AppButton(
                    context: context,
                    buttontext: "Guardar",
                    onclick: () {
                      for (int i = 0; i < instructions.length; i++) {
                        context.read<AccommodationInstructionBloc>().add(
                          AccommodationInstructionUpdateEvent(
                            instructions[i].id ?? 0,
                            _instructionsController[i].text,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
        /* SizedBox(height: MediaQuery.of(context).size.height * 0.22),*/
      ),
    );
  }
}
