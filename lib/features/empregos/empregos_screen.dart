import 'package:flutter/material.dart';
import 'package:marcahoras3/utils/database/supabase_helper.dart';
import 'package:marcahoras3/utils/extensions/contexthelper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../strings.dart';

class EmpregosScreen extends StatefulWidget {
  const EmpregosScreen({super.key});

  @override
  State<EmpregosScreen> createState() => _EmpregosScreenState();
}

class _EmpregosScreenState extends State<EmpregosScreen> {
  var isLoading = true;
  var user = '';
  var userId = '';

  void _safeSnackbarMessage(String text) {
    whenMounted(() => context.showTextSnackbar(text));
  }

  Future<void> _getProfile() async {
    setState(() => isLoading = true);

    try {
      userId = supabaseInstance.auth.currentUser!.id;
      final data = await supabaseInstance
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      user = (data['username'] ?? '') as String;
    } on PostgrestException catch (e) {
      _safeSnackbarMessage(e.message);
    } catch (e) {
      _safeSnackbarMessage(e.toString());
    } finally {
      whenMounted(() => setState(() => isLoading = false));
    }
  }

  Future<void> _disconnect() async {
    try {
      await supabaseInstance.auth.signOut();
    } on AuthException catch (e) {
      _safeSnackbarMessage(e.message);
    } catch (e) {
      _safeSnackbarMessage(e.toString());
    } finally {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(Routes.splash);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Olá $user, de id $userId"),
          ElevatedButton(
            onPressed: _disconnect,
            child: const Text('desconectar'),
          ),
        ],
      ),
    );
  }
}

extension MountHelper on State {
  void whenMounted(VoidCallback secureAction) {
    if (!mounted) return;
    secureAction();
  }
}
