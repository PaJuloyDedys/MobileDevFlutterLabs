import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';
import '../services.dart' as di;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _S();
}

class _S extends State<ProfileScreen> {
  final name = TextEditingController();
  final bio = TextEditingController();
  String email = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final u = await di.auth.current();
    if (u == null) return;
    setState(() {
      email = u.email;
      name.text = u.name;
      bio.text = u.bio ?? '';
    });
  }

  Future<void> _save() async {
    final u = await di.auth.current();
    if (u == null) return;
    final nu = u.copyWith(name: name.text.trim(), bio: bio.text.trim());
    await di.auth.update(nu);
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Saved')));
    }
  }

  @override
  Widget build(BuildContext c) {
    return AppScaffold(
      title: 'Profile',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(email, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          AppTextField(controller: name, label: 'Display name'),
          const SizedBox(height: 12),
          AppTextField(controller: bio, label: 'Bio'),
          const SizedBox(height: 16),
          PrimaryButton(onPressed: _save, text: 'Save'),
        ],
      ),
    );
  }
}
