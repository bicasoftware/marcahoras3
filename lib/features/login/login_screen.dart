import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marcahoras3/utils/database/supabase_helper.dart';
import 'package:marcahoras3/utils/extensions/contexthelper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _loading = false;
  var _redirecting = false;

  final _controller = TextEditingController(text: '');
  late final StreamSubscription<AuthState> _authState;

  Future<void> _signIn() async {
    try {
      setState(() => _loading = true);

      await supabaseInstance.auth.signInWithOtp(
          email: _controller.text.trim(),
          emailRedirectTo:
              kIsWeb ? null : "io.supabase.horas://login-callback/");

      if (mounted) {
        context.showTextSnackbar('Confira seu Email');
        _controller.clear();
      }
    } on AuthException catch (e) {
      if(mounted) context.showTextSnackbar(e.message);
    } catch (e) {
      if(mounted) context.showTextSnackbar("Falha ao entrar");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    _authState = supabaseInstance.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      if (data.session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed(Routes.empregos);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _authState.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrar')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const Text('Sign in via the magic link with your email below'),
          const SizedBox(height: 18),
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _loading ? null : _signIn,
            child: Text(_loading ? 'Loading' : 'Send Magic Link'),
          ),
        ],
      ),
    );
  }
}
