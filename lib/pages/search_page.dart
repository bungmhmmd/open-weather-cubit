import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  String? _city;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void _submit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }
    form.save();
    Navigator.pop(context, _city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: Column(children: [
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              autofocus: false,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                labelText: 'City name',
                hintText: 'more than 2 characters',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().length < 2) {
                  return 'City name must be at least 2 characters long';
                }
                return null;
              },
              onSaved: (value) {
                _city = value;
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: _submit,
              child: Text(
                "How's the weather?",
                style: TextStyle(fontSize: 20),
              ))
        ]),
      ),
    );
  }
}
