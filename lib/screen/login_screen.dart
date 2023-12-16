import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _isPasswordVisible = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  void checkUserLoginStatus() async {
    final user = auth.currentUser;
    if (user != null) {
      // Pengguna belum login, arahkan ke halaman login
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  Future<bool> login(BuildContext context) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // Gunakan context yang benar di sini
        return true; // Login berhasil
      }
    } catch (e) {
      // Gunakan context yang benar di sini jika Anda perlu
      print("Error: $e");
      return false;
      // Handle kesalahan
    }
    return false; // Login gagal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: _formkey,
            child: Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero(
                  //   tag: 'hero',
                  //   child: CircleAvatar(
                  //     backgroundColor: Colors.transparent,
                  //     radius: 34.0,
                  //     child: Image.asset('assets/icons/logo_tpm.png'),
                  //   ),
                  // ),
                  Text("MonitorNovi",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 30,
                            color: Color(0xff212121),
                            fontWeight: FontWeight.bold),
                      )),
                  Text("Silahkan Login",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 12, color: Color(0xff383838)),
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 30,
                          margin: const EdgeInsets.only(
                              top: 4, left: 16, bottom: 1, right: 16),
                          decoration: const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xff2D8EFF)),
                              )),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null) {}
                              return null;
                            },
                            onChanged: (str) {
                              setState(() {});
                            },
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                            decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.account_box_outlined,
                                  color: Color(0xff2D8EFF),
                                  size: 18,
                                ),
                                hintText: "Email",
                                border: InputBorder.none,
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 9),
                                fillColor: Colors.grey,
                                hintStyle: TextStyle(
                                    color: Color(0xff2D8EFF), fontSize: 12)),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 30,
                          margin: const EdgeInsets.only(
                              top: 4, left: 16, bottom: 1, right: 16),
                          decoration: const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xff2D8EFF)),
                              )),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null) {}
                              return null;
                            },
                            onChanged: (str) {
                              setState(() {});
                            },
                            obscureText: _isPasswordVisible,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                            decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.lock,
                                  color: Color(0xff2D8EFF),
                                  size: 18,
                                ),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    }),
                                hintText: "Password",
                                border: InputBorder.none,
                                errorStyle: const TextStyle(
                                    color: Colors.red, fontSize: 9),
                                fillColor: Colors.grey,
                                hintStyle: const TextStyle(
                                    color: Color(0xff2D8EFF), fontSize: 12)),
                          ),
                        ),
                        InkWell(
                          splashColor: const Color(0xff7474BF),
                          onTap: () async {
                            bool loginResult = await login(context);
                            if (loginResult) {
                              // Login berhasil
                              Navigator.pushReplacementNamed(context, "/home");
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Password Salah",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 50.0),
                            height: 43,
                            width: MediaQuery.of(context).size.width / 1.2,
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 28),
                                      blurRadius: 40,
                                      spreadRadius: -12)
                                ],
                                color: Color.fromARGB(255, 39, 199, 191),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Center(
                              child: Text(
                                "Masuk",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
