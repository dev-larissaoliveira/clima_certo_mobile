import 'package:clima_certo_639/constants.dart';
import 'package:clima_certo_639/src/core/components/page_title.dart';
import 'package:clima_certo_639/src/core/mixins/validations_mixin.dart';
import 'package:clima_certo_639/src/core/widgets/TextFields/input_field.dart';
import 'package:clima_certo_639/src/core/widgets/Buttons/rounded_button.dart';
import 'package:clima_certo_639/src/core/widgets/rounded_icon.dart';
import 'package:clima_certo_639/src/modules/auth/stores/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationsMixin {
  Constants myConstants = Constants();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  late final LoginStore _loginStore;

  @override
  void initState() {
    super.initState();

    _loginStore = Modular.get<LoginStore>();

    reaction((_) => _loginStore.hasError, (bool hasError) {
      if (hasError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(_loginStore.errorMessage),
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
                  height: size.height / 2,
                  color: myConstants.primaryColor,
                  child: upSide(size),
                ),
                const PageTitle(
                  title: "Faça seu login",
                  padding: EdgeInsets.only(top: 135),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 190.0),
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
                      children: [
                        const SizedBox(height: 15),
                        socialIconButton(),
                        const SizedBox(height: 15),

                        //Divider
                        Container(
                          width: size.width / 1.5,
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'ou',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              InputField(
                                validator: isNotEmpty,
                                hintText: "E-mail",
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: myConstants.primaryColor,
                                ),
                                textInputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onChanged: (val) => _loginStore.setEmail(val!),
                              ),
                              const SizedBox(height: 20),
                              InputField(
                                hintText: "Senha",
                                onChanged: (val) =>
                                    _loginStore.setPassword(val!),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: myConstants.primaryColor,
                                ),
                                obscureText: !_showPassword,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  child: Icon(
                                    _showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: myConstants.primaryColor,
                                  ),
                                ),
                                validator: isNotEmpty,
                              ),
                              const SizedBox(height: 10),
                              switchListTile(),
                              loginButton(),
                              const SizedBox(height: 10),
                              signUp(),
                              const SizedBox(height: 20),
                              Text(
                                'Redefinir acesso',
                                style: TextStyle(
                                    color: myConstants.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                              const SizedBox(height: 20)
                            ],
                          ),
                        ),
                      ],
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

  loginButton() {
    return Observer(
      builder: (_) {
        if (_loginStore.loading) {
          return CircularProgressIndicator();
        } else {
          // Exibir botão de login se o estado de carregamento estiver inativo
          return RoundedButton(
            text: 'ENTRAR',
            press: () {
              if (_formKey.currentState!.validate()) {
                _loginStore.login();
              }
            },
          );
        }
      },
    );
  }

  socialIconButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        RoundedIcon(imageUrl: "assets/app/google.jpg"),
        SizedBox(
          width: 20,
        ),
        RoundedIcon(imageUrl: "assets/app/twitter.png"),
        SizedBox(
          width: 20,
        ),
        RoundedIcon(imageUrl: "assets/app/facebook.png"),
      ],
    );
  }

  switchListTile() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 40),
      child: SwitchListTile(
        dense: true,
        title: const Text(
          'Lembrar minha senha',
          style: TextStyle(fontSize: 16, fontFamily: 'OpenSans'),
        ),
        value: _loginStore.saveCredentials,
        activeColor: myConstants.primaryColor,
        onChanged: (val) => _loginStore.setSaveCredentials(val),
      ),
    );
  }

  signUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Não tem uma conta?",
          style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 20),
        InkWell(
          onTap: () {
            Modular.to.navigate('auth/signup');
          },
          child: Text(
            "Cadastre-se",
            style: TextStyle(
                color: myConstants.primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Opensans'),
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
          height: size.height / 3,
        ),
      ],
    );
  }
}
