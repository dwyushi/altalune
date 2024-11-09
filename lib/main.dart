import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const _HomeScreen(),
      routes: {
        '/home': (context) => const _HomeScreen(),
        '/login': (context) => _LoginPage(),
        '/signup': (context) => _SignUpPage(),
        '/dashboard': (context) => _DashboardPage(),
      },
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  void _navigateTo(String route) {
    if (route == '/login') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _LoginPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _SignUpPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/imgs/home_bg1.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/imgs/altalune-by-dwyu_logo.png',
                width: 550,
                height: 350,
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  // Log in button
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: 300,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () => _navigateTo('/login'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 29, 51, 150),
                              Color.fromARGB(255, 64, 75, 162)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                              fontFamily: 'InknutAntiqua',
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Sign up button
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 1),
                    width: 300,
                    height: 60,
                    child: OutlinedButton(
                      onPressed: () => _navigateTo('/signup'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color.fromARGB(255, 39, 37, 166),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontFamily: 'InknutAntiqua',
                          fontSize: 18,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Log in page
class _LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<_LoginPage> {
  bool _isChecked = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/imgs/login_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Back button
          Positioned(
            top: 60,
            left: 10,
            child: IconButton(
              icon: Image.asset(
                'assets/imgs/back_btn.png',
                width: 18,
                height: 18,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const _HomeScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, -1.0);
                      const end = Offset.zero;
                      const curve = Curves.decelerate;

                      var curvedAnimation =
                          CurvedAnimation(parent: animation, curve: curve);
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = curvedAnimation.drive(tween);

                      return SlideTransition(
                          position: offsetAnimation, child: child);
                    },
                    transitionDuration: const Duration(milliseconds: 900),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Log in',
                  style: TextStyle(
                    height: 3,
                    fontFamily: 'EmilysCandy',
                    fontSize: 45,
                    color: Colors.white,
                  ),
                ),
                //Username text form field
                const SizedBox(height: 10),
                _buildTextFormField('Username or Email', _usernameController),
                //Password text form field
                const SizedBox(height: 10),
                _buildTextFormField('Password', _passwordController,
                    isPassword: true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            side: WidgetStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                  width: 1.0, color: Colors.white),
                            ),
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                        ),
                        const Text(
                          'Remember me',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          color: Color(0xFF03114C),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // login btn
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ).copyWith(
                    side: WidgetStateProperty.all(
                      const BorderSide(color: Colors.transparent),
                    ),
                    foregroundColor:
                        WidgetStateProperty.all(Colors.transparent),
                  ),
                  child: SizedBox(
                    width: 500,
                    height: 45,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF1A2E8B),
                            Color(0xFF6D79CD),
                            Color(0xFF1A2E8B)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          fontFamily: 'InknutAntiqua',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                //Continue With
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.5),
                          thickness: 1,
                          indent: 60,
                          endIndent: 10,
                        ),
                      ),
                      const Text(
                        'or Continue with',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.5),
                          thickness: 1,
                          indent: 10,
                          endIndent: 60,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: SizedBox(
                        width: 25,
                        height: 25,
                        child: Image.asset('assets/imgs/google.png'),
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset('assets/imgs/apple-logo.png'),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const Spacer(),
                //Don't have an acc
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            color: Color(0xFFBCAFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
        ),
        const SizedBox(height: 5),
        Container(
          width: 290,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFBBC7E7),
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword,
            style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: Color.fromARGB(255, 19, 10, 90)),
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 33, 28, 112),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Sign Up Page
class _SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<_SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/imgs/signup_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Back button
          Positioned(
            top: 60,
            left: 10,
            child: IconButton(
              icon: Image.asset(
                'assets/imgs/back_btn.png',
                width: 18,
                height: 18,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const _HomeScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, -1.0);
                      const end = Offset.zero;
                      const curve = Curves.decelerate;

                      var curvedAnimation =
                          CurvedAnimation(parent: animation, curve: curve);
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = curvedAnimation.drive(tween);

                      return SlideTransition(
                          position: offsetAnimation, child: child);
                    },
                    transitionDuration: const Duration(milliseconds: 900),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    height: 0,
                    fontFamily: 'EmilysCandy',
                    fontSize: 45,
                    color: Colors.white,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      _buildTextFormField('Username*', _usernameController),
                      const SizedBox(height: 20),
                      _buildTextFormField('Email*', _emailController),
                      const SizedBox(height: 20),
                      _buildTextFormField('Password*', _passwordController,
                          isPassword: true),
                      const SizedBox(height: 20),
                      _buildTextFormField(
                          'Confirm Password*', _confirmPasswordController,
                          isPassword: true),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Sign up button
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF1A2E8B),
                            Color(0xFF6D79CD),
                            Color(0xFF1A2E8B),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: 350,
                        height: 45,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Sign up',
                                style: TextStyle(
                                  fontFamily: 'InknutAntiqua',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                //Continue with
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.5),
                          thickness: 1,
                          indent: 50,
                          endIndent: 10,
                        ),
                      ),
                      const Text(
                        'or Continue with',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.5),
                          thickness: 1,
                          indent: 10,
                          endIndent: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: SizedBox(
                        width: 25,
                        height: 25,
                        child: Image.asset('assets/imgs/google.png'),
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset('assets/imgs/apple-logo.png'),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const Spacer(),
                // Don't have an account
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            color: Color(0xFFBCAFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return SizedBox(
      width: 290,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(
          color: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          if (label == 'Confirm Password*' &&
              value != _passwordController.text) {
            return 'Passwords do not match';
          }
          if (label == 'Email*' &&
              !RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: Colors.white60,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1F1B73)),
          ),
        ),
      ),
    );
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushNamed(context, '/dashboard');
      });
    }
  }
}

// Dashboard Page
class _DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Welcome!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
