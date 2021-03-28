import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/screens/signup/signup_screen.dart';
import 'package:xlo_mobx/stores/login_store.dart';


class LoginScreen extends StatelessWidget {

  final LoginStore loginStore = LoginStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card( // cria uma area branca
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
            ),
            elevation: 8,
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Observer(
                    builder: (_){
                      return  ErrorBox(
                        message: loginStore.error,
                      );
                    },
                  ),
                  Text(
                    'Acessar com E-mail',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900]
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 4, top: 8),
                    child: Text("E-mail", style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),),
                  ),
                  Observer(
                    builder: (_){
                      return TextField(
                        decoration: InputDecoration(
                            enabled: !loginStore.loading,
                            border: OutlineInputBorder(),
                            errorText: loginStore.emailError,
                            isDense: true //diminui um pouco
                        ),
                        onChanged: loginStore.setEmail,
                        keyboardType: TextInputType.emailAddress,
                      );
                    },
                  ),
                  SizedBox(height: 16,),
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Senha", style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        ),),
                        GestureDetector(
                            child: Text("Esqueceu sua senha?",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.purple
                            ),),
                          onTap: (){

                          },
                        )
                      ],
                    )
                  ),
                  Observer(
                    builder: (_){
                      return TextField(
                        enabled: !loginStore.loading,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true, //diminui um pouco
                            errorText: loginStore.passwordError
                        ),
                        onChanged: loginStore.setPassword,
                        obscureText: true,
                      );
                    },
                  ),
                  SizedBox(height: 16,),
                  Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(vertical: 12),
                    child: Observer(
                      builder: (_){
                        return RaisedButton(
                          color: Colors.orange,
                          child: loginStore.loading
                                 ? CircularProgressIndicator()
                                 :  Text("ENTRAR"),
                          textColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          onPressed: loginStore.loginPressed,
                        );
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text("Não tem uma conta? ",style: TextStyle(
                          fontSize: 16
                        ),),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => SignupScreen())
                            );
                          },
                          child: Text("Cadastre-se", style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            color: Colors.purple
                          ),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
