import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/screens/signup/field_title.dart';
import 'package:xlo_mobx/stores/signup_store.dart';

class SignupScreen extends StatelessWidget {

  final SignupStore signupStore = SignupStore();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),
            elevation: 8,
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Observer(
                  builder: (_){
                    return ErrorBox(
                      message: signupStore.error
                    );
                  },
                ),
                SizedBox(height: 20,),
                FieldTitle(title: "Apelido", subtitle: "Como aparecerá nos seus anúncios",),
                Container(
                  //margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Observer(
                    builder: (_){
                      return TextField(
                        decoration: InputDecoration(
                            enabled: !signupStore.loading,
                            border: OutlineInputBorder(),
                            isDense: true,
                            hintText: "Exemplo Joao S.",
                            errorText: signupStore.nameError
                        ),
                        onChanged: signupStore.setName,
                      );
                    },
                  ),
                ),
                FieldTitle(
                  title: "E-mail",
                  subtitle: "Enviaremos um e-mail de confirmação",
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child:Observer(
                    builder: (_){
                      return  TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            hintText: "Exemplo Joao@gmail.com",
                            errorText: signupStore.emailError
                        ),
                        onChanged: signupStore.setEmail,
                        keyboardType: TextInputType.emailAddress,
                      );
                    },
                  ),
                ),
                FieldTitle(
                  title: "Celular",
                  subtitle: "",
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Observer(
                    builder: (_){
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            hintText: "(21)98888-8888",
                            errorText: signupStore.phoneError
                        ),
                        onChanged: signupStore.setPhone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly, // somente numero
                          TelefoneInputFormatter() // formatar para padrao de telefone
                        ],
                      );
                    },
                  ),
                ),
                FieldTitle(
                  title: "Senha",
                  subtitle: "Use letras, numeros e caracteries especiais.",
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Observer(
                    builder: (_){
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          errorText: signupStore.pass1Error
                        ),
                        onChanged: signupStore.setPass1,
                        obscureText: true,
                      );
                    },
                  ),
                ),
                FieldTitle(
                  title: "Confirmar Senha",
                  subtitle: "Repita a senha",
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Observer(
                    builder: (_){
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          errorText: signupStore.pass2Error
                        ),
                        onChanged: signupStore.setPass2,
                        obscureText: true,
                      );
                    },
                  ),
                ),
                Observer(
                  builder: (_){
                    return GestureDetector(
                      child: Container(
                          margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: signupStore.isFormValid ? Colors.orange : Colors.grey,
                          ),

                          height: 50,
                          child: Center(
                              child: signupStore.loading
                                  ? CircularProgressIndicator()
                                  : Text("Cadastrar", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                          )
                      )
                      ),
                      onTap: signupStore.signUpPressed,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                    margin: EdgeInsets.symmetric(vertical: 25),
                    child: Divider(color: Colors.black,)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ja tem uma conta? ", style: TextStyle(
                      fontSize: 16
                    ),),
                    GestureDetector(
                        child: Text("Entrar", style: TextStyle(
                          color: Colors.purple,
                          decoration: TextDecoration.underline
                        ),),
                      onTap: Navigator.of(context).pop,
                    )
                  ],
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
