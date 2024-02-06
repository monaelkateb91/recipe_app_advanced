import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app_advanced/pages/register.dart';
import 'package:recipe_app_advanced/providers/auth.provider.dart';

import '../utils/colors.dart';
import '../utils/images.dart';
import '../widgets/scrollable.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  void initState() {
    Provider.of<AuthProvider>(context,listen: false).providerInit();
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(
      children: [Container(decoration: BoxDecoration(
    image: DecorationImage(
        image: AssetImage(ImagePath.background),
        fit: BoxFit.cover)),
    ),
    Container(
    decoration: const BoxDecoration(color: Colors.black38),
    ),
// form key holds the state of the form
     Consumer<AuthProvider>(builder:(context,authprovider,_) =>Form(key: authprovider.formKeyLogin,
         child:  WidgetScrollable(
           isColumn: true,
           columnMainAxisAlignment: MainAxisAlignment.center,
           widgets: [
             Padding(
               padding: const EdgeInsets.only(
                   left: 50, right: 50, top: 50, bottom: 25),
               child: Image.asset(ImagePath.baseHeader),
             ),
             const Text(
               'Login',
               style: TextStyle(color: Colors.white),
             ),
             const SizedBox(
               height: 15,
             ),
             TextFormField(
               controller: authprovider.emailController,
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
                   hintStyle: TextStyle(color: Colors.white),
                   hintText: 'email',
                   prefixIcon: Icon(
                     Icons.person,
                     color: Colors.white,
                   )),
               validator: (value) {
                 if (value == null || (value?.isEmpty ?? false)) {
                   return 'Email Is Required';
                 }
                 return null;
               },
             ),
             const SizedBox(
               height: 15,
             ),
             TextFormField(
               obscureText: authprovider.obsecureText,
               style: const TextStyle(color: Colors.white),
               controller: authprovider.passwordController,
               decoration: InputDecoration(
                   suffixIcon: InkWell(
                     onTap: () => authprovider.toggleObsecure(),
                     child: authprovider.obsecureText
                         ? const Icon(
                       Icons.visibility_off,
                       color: Colors.white,
                     )
                         : const Icon(
                       Icons.visibility,
                       color: Colors.white,
                     ),
                   ),
                   focusedBorder: const UnderlineInputBorder(
                       borderSide: BorderSide(color: Colors.white)),
                   enabledBorder: const UnderlineInputBorder(
                       borderSide: BorderSide(color: Colors.white)),
                   border: const UnderlineInputBorder(
                       borderSide: BorderSide(color: Colors.white)),
                   fillColor: Colors.transparent,
                   filled: true,
                   hintStyle: const TextStyle(color: Colors.white),
                   hintText: 'password',
                   prefixIcon: const Icon(
                     Icons.password,
                     color: Colors.white,
                   )),
               validator: (value) {
                 if (value == null || (value?.isEmpty ?? false)) {
                   return 'Password Is Required';
                 }
                 return null;
               },
             ),
             const SizedBox(
               height: 15,
             ),
             ElevatedButton(
                 style: ElevatedButton.styleFrom(
                     fixedSize: const Size(400, 50),
                     backgroundColor: const Color(ColorsConst.mainColor)),
                 onPressed: () => authprovider.login(context),
                 child:
                 const Text('Login', style: TextStyle(color: Colors.white))),
             const SizedBox(
               height: 15,
             ),
           ],
         ),
     ),
     ),
        if (MediaQuery.of(context).viewInsets.bottom == 0)
          Positioned.fill(
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Register()));
                      },
                      child: const Text(
                        'Not Have Account , Register Now ?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ],
    )


    );}


}
