import 'package:flutter/material.dart';
import 'package:h1d022055_responsi1/bloc/login_bloc.dart';
import 'package:h1d022055_responsi1/helpers/user_info.dart';
import 'package:h1d022055_responsi1/ui/pemandu_wisata_page.dart';
import 'package:h1d022055_responsi1/ui/registrasi_page.dart';
import 'package:h1d022055_responsi1/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontFamily: 'Georgia', color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 125, 125, 125),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Card(
              color: const Color.fromARGB(255, 220, 220, 220),
              elevation: 4.0,
              margin: const EdgeInsets.all(12.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _emailTextField(),
                      const SizedBox(height: 16),
                      _passwordTextField(),
                      const SizedBox(height: 16),
                      _buttonLogin(),
                      const SizedBox(height: 30),
                      _menuRegistrasi(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// Membuat Textbox email
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.black, fontFamily: 'Georgia'),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        errorStyle: const TextStyle(
          color: Color.fromARGB(255, 181, 38, 27), // Warna pesan error
          fontFamily: 'Georgia', // Mengubah font pesan error menjadi Georgia
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      style: const TextStyle(color: Colors.black, fontFamily: 'Georgia'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

// Membuat Textbox password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.black, fontFamily: 'Georgia'),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        errorStyle: const TextStyle(
          color: Color.fromARGB(255, 181, 38, 27), // Warna pesan error
          fontFamily: 'Georgia', // Mengubah font pesan error menjadi Georgia
        ),
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      style: const TextStyle(color: Colors.black, fontFamily: 'Georgia'),
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }

// Membuat Tombol Login
  Widget _buttonLogin() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black, // Background color
      ),
      child: const Text(
        "Login",
        style: TextStyle(color: Colors.white, fontFamily: 'Georgia'),
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) _submit();
        }
      },
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) async {
      if (value.code == 200) {
        await UserInfo().setToken(value.token.toString());
        await UserInfo().setUserID(int.parse(value.userID.toString()));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PemanduWisataPage()));
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const WarningDialog(
                  description: "Login gagal, silahkan coba lagi",
                ));
      }
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Login gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

// Membuat menu untuk membuka halaman registrasi
  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Klik Untuk Registrasi",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.black,
            fontFamily: 'Georgia',
          ),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegistrasiPage()));
        },
      ),
    );
  }
}
