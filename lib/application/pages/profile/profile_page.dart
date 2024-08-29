import 'package:centinelas/application/core/page_config.dart';
import 'package:centinelas/application/core/routes_constants.dart';
import 'package:centinelas/application/core/strings.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/application/pages/home/home_page.dart';
import 'package:centinelas/application/pages/login/login_page.dart';
import 'package:centinelas/application/pages/profile/bloc/profile_bloc.dart';
import 'package:centinelas/application/utils/authentication.dart';
import 'package:centinelas/application/utils/color_utils.dart';
import 'package:centinelas/application/widgets/button_style.dart';
import 'package:centinelas/domain/entities/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePageWidgetProvider extends StatefulWidget {
  const ProfilePageWidgetProvider({
    super.key
  });

  static const pageConfig = PageConfig(
    icon: Icons.person,
    name: profileRoute,
  );

  @override
  State<ProfilePageWidgetProvider> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePageWidgetProvider> {

  final phoneController = TextEditingController();
  String typedPhone = '';
  final emergencyContactNameController = TextEditingController();
  String typedEmergencyContactName = '';
  final emergencyContactPhoneController = TextEditingController();
  String typedEmergencyContactPhone = '';
  final allergiesController = TextEditingController();
  String typedAllergies = '';
  final drugSensitivityController = TextEditingController();
  String typedDrugSensitivities = '';

  String? get errorPhoneText {
    final text = phoneController.value.text;
    if (text.isEmpty || text.length < 10) {
      return errorPhone;
    }
    return null;
  }

  String? get errorEmergencyPhoneText {
    final text = emergencyContactPhoneController.value.text;
    if (text.isEmpty || text.length < 10) {
      return errorPhone;
    }
    return null;
  }

  bool isFABVisible = false;

  late final BlocProvider<ProfileBloc> profileBloc;
  UserDataModel? initialUserData;

  @override
  void initState() {
    super.initState();

    phoneController.addListener(() {
      typedPhone = phoneController.value.text;
      verifyDataModification();
    });
    emergencyContactNameController.addListener(() {
      typedEmergencyContactName =
          emergencyContactNameController.value.text;
      verifyDataModification();
    });
    emergencyContactPhoneController.addListener(() {
      typedEmergencyContactPhone =
          emergencyContactPhoneController.value.text;
      verifyDataModification();
    });
    allergiesController.addListener(() {
      typedAllergies = allergiesController.value.text;
      verifyDataModification();
    });
    drugSensitivityController.addListener(() {
      typedDrugSensitivities= drugSensitivityController.value.text;
      verifyDataModification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => serviceLocator<ProfileBloc>()
        ..loadUserData(),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state){
          if(state is ProfileLoadedState){
            initialUserData = state.userDataModel;
            phoneController.text = initialUserData?.phone ?? '';
            emergencyContactNameController.text =
                initialUserData?.emergencyContactName ?? '';
            emergencyContactPhoneController.text =
                initialUserData?.emergencyContactPhone ?? '';
            allergiesController.text =
                initialUserData?.severeAllergies ?? '';
            drugSensitivityController.text =
                initialUserData?.drugSensitivities ?? '';
          }
        },
        builder: (context, state){
          return buildMainView(context, state);
        },
      ),
    );
  }

  Widget buildMainView(BuildContext context, ProfileState state){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/header_perfil.png',
          fit: BoxFit.contain,
          height: 32,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            if(context.canPop()){
              context.pop();
            } else {
              context.goNamed(
                HomePage.pageConfig.name,
              );
            }
          },
        ),
      ),
      floatingActionButton: Visibility(
          visible: isFABVisible,
          child: FloatingActionButton(
              onPressed: (){writeUserData(context);},
              backgroundColor: redColorCentinelas,
              foregroundColor: Colors.white,
              child: const Icon(Icons.check),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Material(
                elevation: 8,
                child: Container(
                  alignment: Alignment.center,
                  height: 12,
                  child: Container(),
                ),
              ),
              const SizedBox(height: 24,),
              Align(
                alignment: Alignment.topRight,
                child: signOutButton(),
              ),
              const SizedBox(height: 12,),
              LayoutBuilder(
                  builder: (context, constraints){
                    return SizedBox(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset('assets/icon/icon.png'),
                      ),
                    );
                  }
              ),
              const SizedBox(height: 24,),
              Text(
                serviceLocator<FirebaseAuth>().currentUser?.email ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8,),
              /// progress bar
              (state is ProfileLoadedState)
                  ? Container()
                  : const Padding(
                padding: EdgeInsets.fromLTRB(0,24,0,0),
                child: CircularProgressIndicator(),
              ),
              /// phone
              (state is ProfileLoadedState) ? Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: stringPhoneTitle,
                      hintText: hintPhone,
                      errorText: errorPhoneText,
                    ),
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ]
                ),
              ) : spacer(),
              /// emergencyContactName
              (state is ProfileLoadedState) ? Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: stringEmergencyContactName,
                  ),
                  keyboardType: TextInputType.name,
                  controller: emergencyContactNameController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(60),
                    FilteringTextInputFormatter.allow(RegExp(allowedChars))
                  ],
                ),
              ) : spacer(),
              /// emergencyContactPhone
              (state is ProfileLoadedState) ? Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: stringEmergencyContactPhone,
                    hintText: hintPhone,
                    errorText: errorEmergencyPhoneText,
                  ),
                  keyboardType: TextInputType.phone,
                  controller: emergencyContactPhoneController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ]
                ),
              ) : spacer(),
              /// alergies
              (state is ProfileLoadedState) ? Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: stringAllergies
                  ),
                  keyboardType: TextInputType.text,
                  controller: allergiesController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100),
                    FilteringTextInputFormatter.allow(RegExp(allowedChars))
                  ]
                ),
              ) : spacer(),
              /// drugSensitivities
              (state is ProfileLoadedState) ? Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: stringDrugSensitivity
                  ),
                  keyboardType: TextInputType.text,
                  controller: drugSensitivityController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100),
                    FilteringTextInputFormatter.allow(RegExp(allowedChars))
                  ]
                ),
              ) : spacer(),
              const SizedBox(height: 48,),
            ],
          ),
        ),
      ),
    );
  }

  Widget spacer(){
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(),
      ),
    );
  }

  Widget textContainer(String textToPlace){
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(textToPlace),
      ),
    );
  }

  Widget signOutButton(){
    return ElevatedButton(
        onPressed: () async {
          await Authentication.signOut(context: context);
          if(context.mounted) {
            context.goNamed(LoginPage.pageConfig.name);
          }
        },
        style: signOutButtonStyle,
        child: const Wrap(
          children: <Widget>[
            Icon(
              Icons.logout,
            ),
            SizedBox(
              width:10,
            ),
            Text("Cerrar sesión"),
          ],
        )
    );
  }

  void verifyDataModification(){
    try {
      bool isTypedPhoneSameAsCloud =
          typedPhone == (initialUserData?.phone ?? '');
      bool isTypedContactSameAsCloud =
          typedEmergencyContactName == (initialUserData?.emergencyContactName ?? '');
      bool isTypedContactPhoneSameAsCloud =
          typedEmergencyContactPhone == (initialUserData?.emergencyContactPhone ?? '');
      bool isTypedAllergiesSameAsCloud =
          typedAllergies == (initialUserData?.severeAllergies ?? '');
      bool areTypedSensitivitiesSameAsCloud =
          typedDrugSensitivities == (initialUserData?.drugSensitivities ?? '');
      bool phoneTextIs10Digits =
          typedPhone.length==10 ;
      bool emergencyPhoneTextIs10Digits =
          typedEmergencyContactPhone.length==10
              ||  typedEmergencyContactPhone.isEmpty;

      setState(() {
        isFABVisible = (!isTypedPhoneSameAsCloud
            || !isTypedContactSameAsCloud
            || !isTypedContactPhoneSameAsCloud
            || !isTypedAllergiesSameAsCloud
            || !areTypedSensitivitiesSameAsCloud)
            && phoneTextIs10Digits && emergencyPhoneTextIs10Digits
        ;
      });

    }catch (e){
      setState(() {
        isFABVisible = false;
      });
    }
  }

  void writeUserData(BuildContext viewContext) async {
    UserDataModel userDataModel = UserDataModel();
    userDataModel.phone = typedPhone;
    userDataModel.emergencyContactName = typedEmergencyContactName;
    userDataModel.emergencyContactPhone = typedEmergencyContactPhone;
    userDataModel.severeAllergies = typedAllergies;
    userDataModel.drugSensitivities = typedDrugSensitivities;

    await BlocProvider.of<ProfileBloc>(viewContext).updateUserData(userDataModel);
  }
}
