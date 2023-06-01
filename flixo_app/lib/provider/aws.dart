import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider((ref) => Amplify.Auth);

void signOut(BuildContext context, WidgetRef ref) async {
  try {
    final auth = ref.read(authProvider);
    await auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.popUntil(context, ModalRoute.withName('/login'));
  } on AuthException catch (e) {
    print(e.message);
  }
}
