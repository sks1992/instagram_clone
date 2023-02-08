import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/widgets/reusable_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 72),
                //svg image
                SvgPicture.asset(
                  "assets/ic_instagram.svg",
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(height: 40),
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
                    ),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                //textEditing field input for email
                ReusableTextField(
                  hintText: "Enter Your UserName",
                  controller: _userNameController,
                  labelText: "User Name",
                ),
                const SizedBox(height: 24),
                //textEditing field input for email
                ReusableTextField(
                  hintText: "Enter Your Email",
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  labelText: "Email",
                ),
                const SizedBox(height: 24),
                //textEditing field input for password
                ReusableTextField(
                  hintText: "Enter Your Password",
                  controller: _passwordController,
                  isObscureText: true,
                  labelText: 'Password',
                ),
                const SizedBox(height: 24),
                //textEditing field input for Bio
                ReusableTextField(
                  hintText: "Enter Your Bio",
                  controller: _bioController,
                  labelText: 'Bio',
                ),
                const SizedBox(height: 24),

                //button login
                InkWell(
                  onTap: () async {
                    String res = await AuthMethods().signupUser(
                      userName: _userNameController.text,
                      password: _passwordController.text,
                      email: _emailController.text,
                      bio: _bioController.text,
                    );
                    print("SignUpScreen:: Signup Result:: $res");
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        color: blueColor),
                    child: const Text("SignUp"),
                  ),
                ),
                //Transition to siging upPage
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Already Signup. Go To "),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: blueColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
