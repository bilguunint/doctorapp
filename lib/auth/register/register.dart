import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/bloc/auth_bloc/bloc.dart';
import 'package:wallet/bloc/register_bloc/bloc.dart';
import 'package:wallet/style/theme.dart' as Style;
import 'register_button.dart';

class RegisterForm extends StatefulWidget {
  final FirebaseUser user;
  RegisterForm({Key key, @required this.user}) : super(key: key);
  State<RegisterForm> createState() => _RegisterFormState(user);
}

class _RegisterFormState extends State<RegisterForm> {
  final FirebaseUser user;
  _RegisterFormState(this.user);
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _firstNameController.text.isNotEmpty &&
      _lastNameController.text.isNotEmpty &&
      _phoneNumController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _firstNameController.addListener(_onFirstNameChanged);
    _lastNameController.addListener(_onLastNameChanged);
    _phoneNumController.addListener(_onPhonenumChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _registerBloc,
      listener: (BuildContext context, RegisterState state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder(
        bloc: _registerBloc,
        builder: (BuildContext context, RegisterState state) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Container(
                padding: EdgeInsets.only(bottom: 15.0,),
                child: Row(
                        children: <Widget>[
                          Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.0, color: Style.Colors.mainColor),
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: new NetworkImage(user.photoUrl)),
                    )),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      user.displayName, style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    )
                        ],
                      ),
              ),
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[300], width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2.0)),
                            contentPadding: EdgeInsets.only(
                                left: 0.0, top: 20.0, right: 16.0, bottom: 5.0),
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0)),
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                            ),
                            hintText: "Овог",
                            hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF504C6B),
                                fontWeight: FontWeight.bold),
                            labelStyle: TextStyle(
                                fontSize: 13.0,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          autocorrect: false,
                          autovalidate: true,
                        ),
                      ),
                      !state.isLastNameValid
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    EvaIcons.alertCircle,
                                    color: Colors.redAccent,
                                  )))
                          : Container()
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[300], width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2.0)),
                            contentPadding: EdgeInsets.only(
                                left: 0.0, top: 20.0, right: 16.0, bottom: 5.0),
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0)),
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                            ),
                            hintText: "Нэр",
                            hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF504C6B),
                                fontWeight: FontWeight.bold),
                            labelStyle: TextStyle(
                                fontSize: 13.0,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          autocorrect: false,
                          autovalidate: true,
                        ),
                      ),
                      !state.isFirstNameValid
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    EvaIcons.alertCircle,
                                    color: Colors.redAccent,
                                  )))
                          : Container()
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[300], width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: TextFormField(
                          controller: _phoneNumController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2.0)),
                            contentPadding: EdgeInsets.only(
                                left: 0.0, top: 20.0, right: 16.0, bottom: 5.0),
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0)),
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                            ),
                            hintText: "Утасны дугаар",
                            hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF504C6B),
                                fontWeight: FontWeight.bold),
                            labelStyle: TextStyle(
                                fontSize: 13.0,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          autocorrect: false,
                          autovalidate: true,
                        ),
                      ),
                      !state.isPhoneNumValid
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    EvaIcons.alertCircle,
                                    color: Colors.redAccent,
                                  )))
                          : Container()
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                    height: 45,
                    child: RaisedButton(
      color: Style.Colors.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context).dispatch(
                LoggedOut(),
              );
      },
      child: Text('Буцах', style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white)),
    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                      SizedBox(
                    height: 45,
                    child: RegisterButton(
                    onPressed: isRegisterButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  ),
                  )
                    ],
                  ),
                  
                  
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumController.dispose();
    super.dispose();
  }

  void _onFirstNameChanged() {
    _registerBloc.dispatch(
      FirstNameChanged(firstName: _firstNameController.text),
    );
  }

  void _onLastNameChanged() {
    _registerBloc.dispatch(
      LastNameChanged(lastName: _lastNameController.text),
    );
  }

  void _onPhonenumChanged() {
    _registerBloc.dispatch(
      PhoneNumChanged(phoneNum: _phoneNumController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.dispatch(
      Submitted(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          phoneNum: _phoneNumController.text,
          uid: user.uid),
    );
  }
}
