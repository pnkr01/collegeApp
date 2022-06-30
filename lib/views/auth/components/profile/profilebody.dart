import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../global.dart';
import '../../../common/errordialog.dart';
import '../../../common/loading_dialog.dart';
import '../../../home/home.dart';

class BuildProfileBody extends StatefulWidget {
  final String phoneNumber;
  const BuildProfileBody({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<BuildProfileBody> createState() => _BuildProfileBodyState();
}

class _BuildProfileBodyState extends State<BuildProfileBody> {
  // ignore: prefer_typing_uninitialized_variables
  var selectedColleges;
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.2,
      bottom: 0,
      left: size.width * 0.0002,
      right: size.width * 0.0002,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // color: Colors.red,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 50.0,
              right: 50.0,
            ),
            child: Column(
              children: [
                TextField(
                  controller: fullName,
                  keyboardType: TextInputType.name,
                  cursorHeight: 20,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Full Name *",
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.name,
                  cursorHeight: 20,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email *",
                  ),
                ),
                // TextField(
                //   controller: email,
                //   keyboardType: TextInputType.emailAddress,
                //   cursorHeight: 20,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: "Search College",
                //   ),
                // ),
                const SizedBox(
                  height: 30.0,
                ),
                // StreamBuilder<QuerySnapshot>(
                //     stream: FirebaseFirestore.instance
                //         .collection("college")
                //         .snapshots(),
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return const Text("No Data");
                //       } else {
                //         List<DropdownMenuItem> collegs = [];
                //         for (int i = 0; i < snapshot.data!.docs.length; i++) {
                //           DocumentSnapshot snap = snapshot.data!.docs[i];
                //           collegs.add(
                //             DropdownMenuItem(
                //               child: Text(snap.id),
                //               value: snap.id,
                //             ),
                //           );
                //         }
                //         return InputDecorator(
                //           decoration: const InputDecoration(
                //             border: OutlineInputBorder(),
                //           ),
                //           child: DropdownButtonHideUnderline(
                //             child: DropdownButton<dynamic>(
                //               borderRadius: BorderRadius.circular(20.0),
                //               items: collegs,
                //               onChanged: (val) {
                //                 setState(() {
                //                   selectedColleges = val;
                //                 });
                //               },
                //               value: selectedColleges,
                //               isExpanded: true,
                //               isDense: true,
                //               hint: const Text("Select College"),
                //             ),
                //           ),
                //         );
                //       }
                //     }),
                // TypeAheadField(
                //   hideSuggestionsOnKeyboardHide: false,
                //   debounceDuration: const Duration(milliseconds: 500),
                //   textFieldConfiguration: const TextFieldConfiguration(
                //     decoration: InputDecoration(
                //       prefixIcon: Icon(Icons.search),
                //       border: OutlineInputBorder(),
                //       hintText: "Search College",
                //     ),
                //   ),
                //   suggestionsCallback: UserApi.getUserSuggestion,
                //   itemBuilder: (context, User? suggestion) {
                //     final user = suggestion;
                //     return ListTile(
                //       title: Text(user!.sName),
                //     );
                //   },
                //   noItemsFoundBuilder: (context) => const Center(
                //     child: Text("No College Found"),
                //   ),
                //   onSuggestionSelected: (User suggestion) {
                //     print(suggestion.sName);
                //   },
                // ),
                const SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    validateForm(context);
                    //TODOS: Send to account sucessfully created screen.
                    //TODOS : on continue button clicked.
                    // setState(() {
                    //   validateForm(context);
                    // });
                  },
                  child: SizedBox(
                    height: size.height * 0.06,
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateForm(BuildContext context) async {
    if (fullName.text.isNotEmpty && email.text.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return const LoadingDialog(
              message: "",
            );
          });
      await sharedPreferences!.setBool("sendToHome", true);
      await saveDataToFirebase(context);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const ErrorDialog(
              message: "Please fill all details",
            );
          });
    }
  }

  saveDataToFirebase(BuildContext context) async {
    //TODOS: SETTING WILL BE HAPPEN AFTER VECHICLE ADDITION.
    //TODOS: IF NEW USER LEFT VECH ADD AND CLOSE APP THEN AGAIN HE/SHE HAVE TO FILL THIS.
    await FirebaseFirestore.instance
        .collection("phone")
        .doc(widget.phoneNumber)
        .set(
          ({
            "userEmail": email.text.trim(),
            "phoneNumber": widget.phoneNumber.trim(),
            "fullName": fullName.text.trim(),
          }),
        );

    // SharedPreferences? sharedPreferences =
    //     await SharedPreferences.getInstance();
    await sharedPreferences!.setString("email", email.text.trim());
    await sharedPreferences!.setString("fullName", fullName.text.trim());
    await sharedPreferences!
        .setString("phoneNumber", sharedPreferences!.getString("phone")!);
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        //TODOS: WHERE TO SEND USER AFTER COMPLETE SIGN IN...
        builder: (context) => const MyHomePage(),
      ),
      (route) => false,
    );
    showSnackBar(context, "LoggedIn Sucessfully");
  }
}
