import 'package:firebase_provider/core/BaseAuth.dart';
import 'package:firebase_provider/helper/HelperColor.dart';
import 'package:firebase_provider/helper/HelperFlushbar.dart';
import 'package:firebase_provider/widget/WIdgetTextField.dart';
import 'package:firebase_provider/widget/WidgetButton.dart';
import 'package:firebase_provider/widget/WidgetText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ModelAuthentication.dart';
import '../models/ModelResponce.dart';
import '../models/enum.dart';
import '../providers/ProviderAuthentication.dart';
import '../providers/ProviderPassword.dart';

/// ScreenAuthentication this class is used to login and sign up activity
/// we manage both the activity from this screen by using enum
class ScreenAuthentication extends StatefulWidget {
  @override
  _ScreenAuthenticationState createState() => _ScreenAuthenticationState();
}

class _ScreenAuthenticationState extends State<ScreenAuthentication> {
  /// Here we define the controllers for text field
  TextEditingController controllerUserName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  // This parameter is used to validate the form
  GlobalKey<FormState> formKey = GlobalKey();

  // To show loading, error on button we need to add this controller
  WidgetButtonController controllerButton = WidgetButtonController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAuthentication>(
        builder: (context, callBack, child) {
      /// here we simply get the view state from that view state we manage login and sign up view
      ViewState viewState = callBack.getViewState;

      /// we are showing error or success on the basis of call back response
      if (callBack.response.messageCode == 400) {
        controllerButton.reset!();
        showErrorMessage(callBack.response.responseMessage);
      } else if (callBack.response.messageCode == 200) {
        controllerButton.reset!();
        if (callBack.response.responseMessage == "User Register Successfully") {
          showSuccessMessage(callBack.response.responseMessage);
          FocusScope.of(context).unfocus();
        }
        clearController();
      }
      return Scaffold(
        backgroundColor: HelperColor.colorBackGround,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  child: widgetText("e-Shop",
                      textStyle: textStyle(
                          textColor: HelperColor.colorPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      /// if the view state is sing up then we need to show name field as well
                      if (viewState == ViewState.SignUp)
                        WidgetTextFormField(
                          controller: controllerUserName,
                          fillColor: Colors.white,
                          hintText: "Name",
                          modelTextField: ModelTextField(isCompulsory: true),
                          enumValidator: EnumValidator.text,
                        ),
                      WidgetTextFormField(
                        controller: controllerEmail,
                        fillColor: Colors.white,
                        hintText: "Email",
                        enumTextInputType: EnumTextInputType.email,
                        modelTextField: ModelTextField(isCompulsory: true),
                        enumValidator: EnumValidator.email,
                      ),

                      /// Here we wrap this textfield with the provider because we need to change
                      /// or we need hide/show the password field on the basis of user selection
                      Consumer<ProviderPassword>(
                          builder: (context, callBackPassword, child) {
                        return WidgetTextFormField(
                          controller: controllerPassword,
                          fillColor: Colors.white,
                          hintText: "Password",
                          modelTextField: ModelTextField(isCompulsory: true),
                          obscureText: callBackPassword.getObsecureText,
                          enumValidator: EnumValidator.text,
                          widgetSuffix: InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              callBackPassword.setObsecureText(
                                  !callBackPassword.getObsecureText);
                            },
                            child: Icon(callBackPassword.getObsecureText
                                ? Icons.lock
                                : Icons.lock_open),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      WidgetButton(
                        controller: controllerButton,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            controllerButton.loading!();

                            /// if view state is sign in then we called the sign in method
                            /// else we called register method
                            if (viewState == ViewState.SignIn) {
                              callBack.signInUser(
                                userData: ModelAuthentication(
                                    userEmail:
                                        controllerEmail.text.toString().trim(),
                                    userPassword: controllerPassword.text
                                        .toString()
                                        .trim(),
                                    context: context,
                                    firebaseAuth: Provider.of<BaseAuth>(context,
                                            listen: false)
                                        .authState),
                              );
                            } else {
                              callBack.registerNewUser(
                                userData: ModelAuthentication(
                                    userName: controllerUserName.text
                                        .toString()
                                        .trim(),
                                    userEmail:
                                        controllerEmail.text.toString().trim(),
                                    userPassword: controllerPassword.text
                                        .toString()
                                        .trim(),
                                    context: context,
                                    firebaseAuth: Provider.of<BaseAuth>(context,
                                            listen: false)
                                        .authState),
                              );
                            }
                          }
                        },
                        title:
                            viewState == ViewState.SignIn ? "Login" : "Sign Up",
                      ),
                      InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          formKey.currentState!.reset();
                          clearController();
                          callBack.response = ModelResponse(
                              responseMessage: "", messageCode: 0);

                          /// from here we change the view
                          if (viewState == ViewState.SignIn) {
                            callBack.setViewState(ViewState.SignUp);
                          } else {
                            callBack.setViewState(ViewState.SignIn);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: viewState == ViewState.SignIn
                                    ? "New here? "
                                    : "Already have an account? ",
                                style: textStyle(
                                    textColor: HelperColor.colorText,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: viewState == ViewState.SignIn
                                    ? "Sign Up"
                                    : "Login",
                                style: textStyle(
                                    textColor: HelperColor.colorPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))
                          ])),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  clearController() {
    controllerEmail.clear();
    controllerUserName.clear();
    controllerPassword.clear();
  }

  showErrorMessage(String msg) {
    return WidgetsBinding.instance.addPostFrameCallback(
        (_) => HelperFlushBar.showFlushBarError(context, msg));
  }

  showSuccessMessage(String msg) {
    return WidgetsBinding.instance.addPostFrameCallback(
        (_) => HelperFlushBar.showFlushBarSuccess(context, msg));
  }
}
