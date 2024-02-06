import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:recipe_app_advanced/providers/auth.provider.dart';
import 'package:recipe_app_advanced/utils/images.dart';

import '../utils/colors.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).providerInit();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImagePath.background), fit: BoxFit.cover)),
      ),
      Container(
        decoration: const BoxDecoration(color: Colors.black38),
      ),
      Consumer<AuthProvider>(
          builder: (context, authProvider, _) => Form(
              key: authProvider.formKeyRegister,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 50, right: 50, top: 50, bottom: 25),
                    child: Image.asset(ImagePath.baseHeader),
                  ),
                  const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: authProvider.emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.transparent,
                          filled: true,
                          hintText: 'email',
                          prefixIcon: Icon(Icons.person, color: Colors.white,),
                          hintStyle: TextStyle(color: Colors.white)),
                      
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(controller: authProvider.passwordController,
                  obscureText: authProvider.obsecureText,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      fillColor: Colors.transparent,
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.white),
                      hintText: 'password',
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Colors.white,
                      ),
                        suffixIcon: InkWell(
                          onTap: ()=>authProvider.toggleObsecure(),
                          child: authProvider.obsecureText?const Icon(Icons.visibility_off,
                          color: Colors.white,):const Icon(Icons.visibility, color: Colors.white,),
                        )
                  ),
                  ),
                const SizedBox(height: 15,),
                  TextFormField(
                    controller: authProvider.nameController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.transparent,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: 'name',
                        prefixIcon: Icon(
                          Icons.document_scanner,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton( style: ElevatedButton.styleFrom(
                    fixedSize: const Size(400,50),
                    backgroundColor: const Color(ColorsConst.mainColor)
                  ),
                      onPressed: (){
                    authProvider.signUp(context);
                      },
                  child: const Text('Register',style: TextStyle(color: Colors.white),),),
                  const Spacer(flex: 2,),
                  const Padding(padding: EdgeInsets.only(top:8),child: Text('Login', style: TextStyle(color:Colors.white),),)
                  
                ],



              )))
    ]));
  }
}
