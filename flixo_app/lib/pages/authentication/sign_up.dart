// import 'package:flixo_app/extension/form_validation.dart';
// import 'package:flixo_app/pages/authentication/login_page.dart';
// import 'package:flixo_app/widget/authentication/custom_form.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class SignUpPage extends HookConsumerWidget {
//   static const routeName = "/SignUpPage";
//   const SignUpPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ValueNotifier<String> _field1 = useState<String>("");
//     ValueNotifier<String> _field2 = useState<String>("");
//     ValueNotifier<String> _field3 = useState<String>("");

//     final _formSingupKey = useMemoized(GlobalKey<FormState>.new);
//     final TextEditingController _userNameController =
//         useTextEditingController();
//     final TextEditingController _emailController = useTextEditingController();
//     final TextEditingController _passwordController =
//         useTextEditingController();

//     final Size size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//       child: Scaffold(
//         backgroundColor: const Color(0xFF4E4E4E),
//         body: Form(
//           key: _formSingupKey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           onChanged: () {},
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: Stack(
//                       children: [
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: IconButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             icon: const Icon(Icons.arrow_back_ios_new_outlined),
//                           ),
//                         ),
//                         Center(
//                           child: Image.asset(
//                             'assets/image/logo.png',
//                             width: 180.0,
//                             height: 180.0,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 50, vertical: 20),
//                     child: CustomForm(
//                       obscureText: false,
//                       controller: _userNameController,
//                       field: _field1,
//                       hintText: "UserName",
//                       labelText: "UserName",
//                       validator: (val) => val!.isEmpty
//                           ? "UWAGA wypełnij to pole!"
//                           : !val.isValidName
//                               ? "Wpisz poprawną nazwe użytkownika"
//                               : null,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 50, vertical: 20),
//                     child: CustomForm(
//                       obscureText: false,
//                       controller: _emailController,
//                       hintText: "Email",
//                       validator: (val) => val!.isEmpty
//                           ? "UWAGA wypełnij to pole!"
//                           : !val.isValidEmail
//                               ? "Wpisz poprawny mail"
//                               : null,
//                       field: _field2,
//                       labelText: "Email",
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 50, vertical: 20),
//                     child: CustomForm(
//                       obscureText: true,
//                       controller: _passwordController,
//                       hintText: "Password",
//                       validator: (val) => val!.isEmpty
//                           ? "UWAGA wypełnij to pole!"
//                           : !val.isValidPassword
//                               ? "Wpisz poprawne hasło"
//                               : null,
//                       field: _field3,
//                       labelText: "Password",
//                     ),
//                   ),
//                   SingleChildScrollView(
//                     physics: const NeverScrollableScrollPhysics(),
//                     child: SizedBox(
//                       width: size.width * 0.8,
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             width: size.width * 0.8,
//                             height: 40,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.black54,
//                                 elevation: 10,
//                               ),
//                               onPressed: () {
//                                 _formSingupKey.currentState!.validate()
//                                     ? Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                           builder: (_) => const LoginPage(),
//                                         ),
//                                       )
//                                     : null;
//                               },
//                               child: const Text("Singup"),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text(
//                               "Forgot password?",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 50, vertical: 50),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SizedBox(
//                           height: 80,
//                           width: 80,
//                           child: Card(
//                             elevation: 10,
//                             color: Colors.white,
//                             child: IconButton(
//                               onPressed: () {},
//                               icon: Image.asset('assets/image/google-logo.png'),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 80,
//                           width: 80,
//                           child: Card(
//                             elevation: 10,
//                             color: Colors.white,
//                             child: IconButton(
//                               onPressed: () {},
//                               icon:
//                                   Image.asset('assets/image/facebook-logo.png'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
