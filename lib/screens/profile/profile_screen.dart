import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: ProfileScreenBody(),
    );
  }
}

class ProfileScreenBody extends StatelessWidget {
  ProfileScreenBody({Key? key}) : super(key: key);

  TextEditingController? mailController;

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    mailController = TextEditingController(
      text: profileController.firebaseAuth.currentUser?.email,
    );

    if (profileController.state == ProfileState.initial ||
        profileController.state == ProfileState.loaded) {
      return Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await profileController.pickImage();
                      await profileController.uploadImage();
                      await profileController.updateProfilePhoto();
                    },
                    child:
                        profileController.firebaseAuth.currentUser?.photoURL ==
                                null
                            ? CircleAvatar(
                                radius: 30,
                                child: Icon(
                                  Icons.person,
                                  size: 30.r,
                                ),
                              )
                            : CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(profileController
                                    .firebaseAuth.currentUser!.photoURL!),
                              ),
                  ),
                  10.horizontalSpace,
                  Column(
                    children: const [
                      Text(
                        'Change Profile Photo',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Max Upload Limit: 2MB',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              20.verticalSpace,
              Container(
                padding: const EdgeInsets.all(defaultPadding),
                decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Name'),
                    10.verticalSpace,
                    TextFormField(
                      readOnly: true,
                      initialValue: profileController
                          .firebaseAuth.currentUser?.displayName,
                      decoration: InputDecoration(
                          fillColor: bgColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)))),
                      onChanged: (value) {},
                    ),
                    20.verticalSpace,
                    const Text('Surname'),
                    10.verticalSpace,
                    TextFormField(
                      readOnly: true,
                      initialValue: profileController
                          .firebaseAuth.currentUser?.displayName,
                      decoration: InputDecoration(
                          fillColor: bgColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)))),
                      onChanged: (value) {},
                    ),
                    20.verticalSpace,
                    const Text('Phone Number'),
                    10.verticalSpace,
                    TextFormField(
                      readOnly: true,
                      initialValue: profileController
                          .firebaseAuth.currentUser?.phoneNumber,
                      decoration: InputDecoration(
                          fillColor: bgColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)))),
                      onChanged: (value) {},
                    ),
                    20.verticalSpace,
                    const Text('Mail'),
                    10.verticalSpace,
                    TextFormField(
                      controller: mailController,
                      decoration: InputDecoration(
                          fillColor: bgColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)))),
                      onChanged: (value) {},
                    ),
                    10.verticalSpace,
                    // const Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Text(
                    //     'Want to change your pass?',style: ,
                    //   ),
                    // ),
                  ],
                ),
              ),
              10.verticalSpace,
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await profileController.updateMail(mailController!.text);
                  },
                  child: const Text('Save'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(secondaryColor),
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 40.r, vertical: 10.r)),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else if (profileController.state == ProfileState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(
        child: Text('Error'),
      );
    }
  }
}
