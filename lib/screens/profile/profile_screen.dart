import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    'assets/images/pp.png',
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
                    initialValue: 'Atamer',
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
                    initialValue: 'Sahin',
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
                    initialValue: '+90323232332',
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
                    initialValue: 'atamer.sahin@etiya.com',
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
                onPressed: () {},
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
  }
}
