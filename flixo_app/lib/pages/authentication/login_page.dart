import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Widget _getPadding(Widget content) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
    child: content,
  );
}

// Widget _textField( controller,String labelText)
// {
//   return TextFormField(
//                   autocorrect: true,
//                   cursorColor: Colors.black,
//                   textAlign: TextAlign.left,
//                   controller: controller,
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     filled: true,
//                     helperMaxLines: 1,
//                     errorText: "UWAGA wypełnij to pole!",
//                     fillColor: Colors.white,
//                     labelText: labelText,
//                     focusColor: Color(0xFF00BDC6),
//                   ),
//                   onSaved: (value) => _field1 = value!,
//                 );

// }

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String _field1;
    String _field2;
    final _formKey = GlobalKey<FormState>();
    final ValueNotifier<int> counter = useState(0);
    final TextEditingController _emailController = useTextEditingController();
    final TextEditingController _passwordController =
        useTextEditingController();

    void _saveForm() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFF4E4E4E),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: () {},
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              _getPadding(
                Image.asset(
                  'assets/image/logo.png',
                  width: 180.0,
                  height: 180.0,
                  fit: BoxFit.fill,
                ),
              ),
              _getPadding(
                TextFormField(
                  autocorrect: true,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.left,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    helperMaxLines: 1,
                    errorText: "UWAGA wypełnij to pole!",
                    fillColor: Colors.white,
                    labelText: "email",
                    focusColor: Color(0xFF00BDC6),
                  ),
                  onSaved: (value) => _field1 = value!,
                ),
              ),
              _getPadding(
                TextFormField(
                  autocorrect: true,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.left,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    helperMaxLines: 1,
                    errorText: "UWAGA wypełnij to pole!",
                    fillColor: Colors.white,
                    labelText: "password",
                    focusColor: Color(0xFF00BDC6),
                  ),
                  onSaved: (value) => _field2 = value!,
                ),
              ),
              TextButton(
                onPressed: () {
                  _saveForm();
                },
                child: const Text("LogIn"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
