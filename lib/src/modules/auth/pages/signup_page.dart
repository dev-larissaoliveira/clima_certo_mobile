import 'dart:io';
import 'package:clima_certo_639/constants.dart';
import 'package:clima_certo_639/src/core/components/page_title.dart';
import 'package:clima_certo_639/src/core/mixins/validations_mixin.dart';
import 'package:clima_certo_639/src/core/widgets/TextFields/input_field.dart';
import 'package:clima_certo_639/src/core/widgets/Buttons/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clima_certo_639/src/modules/auth/stores/signup/signup_store.dart';
import 'package:mobx/mobx.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with ValidationsMixin {
  Constants myConstants = Constants();
  final _formKey = GlobalKey<FormState>();
  late final SignupStore _signupStore;

  bool _showPassword = false;
  bool _showConfirmPassword = false;
  File? imageFile;

  @override
  void initState() {
    super.initState();

    _signupStore = Modular.get<SignupStore>();

    reaction((_) => _signupStore.hasError, (bool hasError) {
      if (hasError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(_signupStore.errorMessage),
        ));
      }
    });

    reaction((_) => _signupStore.successMessage, (String successMessage) {
      if (successMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(_signupStore.successMessage),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height / 3,
                  color: myConstants.primaryColor,
                  child: upSide(size),
                ),
                const PageTitle(
                  title: "Cadastre-se",
                  padding: EdgeInsets.only(top: 158),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 210.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [form()],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          InputField(
            controller: TextEditingController(text: _signupStore.fullname),
            validator: isNotEmpty,
            hintText: "Nome",
            prefixIcon: Icon(
              Icons.person,
              color: myConstants.primaryColor,
            ),
            onChanged: (val) => _signupStore.setfullname(val!),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),
          InputField(
            controller: TextEditingController(text: _signupStore.email),
            validator: (val) => combine(
              [
                () => isNotEmpty(val),
                () => isValidEmail(val),
              ],
            ),
            hintText: "E-mail",
            prefixIcon: Icon(
              Icons.email,
              color: myConstants.primaryColor,
            ),
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (val) => _signupStore.setEmail(val!),
          ),
          const SizedBox(height: 20),
          InputField(
            controller: TextEditingController(text: _signupStore.password),
            validator: (val) => combine(
              [
                () => isNotEmpty(val),
                () => hasEightChars(
                    val, 'Sua senha deve conter pelo menos 8 caracteres.'),
              ],
            ),
            hintText: "Senha",
            onChanged: (val) => _signupStore.setPassword(val!),
            prefixIcon: Icon(
              Icons.lock,
              color: myConstants.primaryColor,
            ),
            obscureText: !_showPassword,
            textInputAction: TextInputAction.next,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
              child: Icon(
                _showPassword ? Icons.visibility_off : Icons.visibility,
                color: myConstants.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          InputField(
            controller:
                TextEditingController(text: _signupStore.confirmPassword),
            onChanged: (val) => _signupStore.setConfirmPassword(val!),
            validator: (val) => combine(
              [
                () => isNotEmpty(val),
                () => hasEightChars(
                    val, 'Sua senha deve conter pelo menos 8 caracteres.'),
                () => passwordsMatch(_signupStore.password, val),
              ],
            ),
            textInputAction: TextInputAction.done,
            hintText: "Confirmar senha",
            prefixIcon: Icon(
              Icons.lock,
              color: myConstants.primaryColor,
            ),
            obscureText: !_showConfirmPassword,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  _showConfirmPassword = !_showConfirmPassword;
                });
              },
              child: Icon(
                _showConfirmPassword ? Icons.visibility_off : Icons.visibility,
                color: myConstants.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 15),
          signUp(),
          const SizedBox(height: 10),
          signIn(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  signUp() {
    return RoundedButton(
        text: 'CADASTRAR',
        press: () {
          if (_formKey.currentState!.validate()) {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Para prosseguirmos com o seu cadastro precisamos tirar uma foto sua!",
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Vamos lá?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () async =>
                            await _signupStore.pick(ImageSource.camera),
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        label: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Tire uma foto",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          textStyle: TextStyle(
                            fontSize: 16,
                          ),
                          backgroundColor: myConstants.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xfffeeeee4),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
              ),
            );
          }
        });
  }

  signIn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Já possui uma conta?",
          style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 20),
        InkWell(
          onTap: () {
            Modular.to.pushNamed('/auth/login');
          },
          child: Text(
            "Faça login",
            style: TextStyle(
              color: myConstants.primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Opensans',
            ),
          ),
        )
      ],
    );
  }

  upSide(Size size) {
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height / 2,
          child: Padding(
            padding: EdgeInsets.only(top: size.height * .05),
            child: Image.asset(
              "assets/app/register.png",
              alignment: Alignment.topCenter,
              scale: 5,
            ),
          ),
        ),
      ],
    );
  }
}
