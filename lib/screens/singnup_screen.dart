import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/helpers.dart';
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
  Uint8List? _img;
  bool isLogin = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _img = image;
    });
  }

  void signUpUser() async {
    setState(() {
      isLogin = true;
    });
    String res = await AuthMethods().signupUser(
      email: _emailController.text,
      password: _passwordController.text,
      userName: _userNameController.text,
      bio: _bioController.text,
      file: _img!,
    );
    print("SignUpScreen:: Signup Result:: $res");
    if (res == "success") {
      showSnackBar(res, context, true);
    } else {
      showSnackBar(res, context, false);
    }
    setState(() {
      isLogin = false;
    });
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
                    _img != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_img!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8agLYh5KqNIxsU5B0J5d601gO8ubgENaacYEnP6i52Q&s"),
                          ),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
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
                  onTap: () {
                    signUpUser();
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
                    child: isLogin
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("SignUp"),
                  ),
                ),
                //Transition to signing upPage
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
