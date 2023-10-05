import 'package:admin/controllers/authentication_controller.dart';
import 'package:admin/controllers/menu_controller.dart';
import 'package:admin/controllers/profile_controller.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuControllers>().controlMenu,
          ),
        if (!Responsive.isMobile(context)) ...[
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        ],
        // const Expanded(child: SearchField()),
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    final auth = Provider.of<AuthenticationController>(context);
    return Container(
        margin: const EdgeInsets.only(left: defaultPadding),
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(children: [
          GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
              // await profileController.getAppUserInfo();

              ;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                profileController.firebaseAuth.currentUser!.photoURL != null
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          profileController.firebaseAuth.currentUser!.photoURL!,
                        ),
                      )
                    : const CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.person,
                        ),
                      ),
                SizedBox(
                  width: 10.h,
                ),
                InkWell(
                    onTap: () async {
                      await auth.signOut();
                    },
                    child: const Icon(CupertinoIcons.square_arrow_right)),
              ],
            ),
          ),
        ]));
  }
}






//  return GestureDetector(
//         onTap: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const ProfileScreen(),
//               ));
//         },
//         child: Container(
//           margin: const EdgeInsets.only(left: defaultPadding),
//           padding: const EdgeInsets.symmetric(
//             horizontal: defaultPadding,
//             vertical: defaultPadding / 2,
//           ),
//           decoration: BoxDecoration(
//             color: secondaryColor,
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//             border: Border.all(color: Colors.white10),
//           ),
//           child: Row(
//             children: [
//               Image.asset(
//                 "assets/images/pp.png",
//                 height: 38,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               InkWell(
//                   onTap: () {
//                     AuthenticationController().signOut();
//                   },
//                   child: const Icon(CupertinoIcons.square_arrow_right)),
//             ],


















// class SearchField extends StatelessWidget {
//   const SearchField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         hintText: "Search",
//         fillColor: secondaryColor,
//         filled: true,
//         border: const OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//         ),
//         suffixIcon: InkWell(
//           onTap: () {},
//           child: Container(
//             padding: const EdgeInsets.all(defaultPadding * 0.75),
//             margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
//             decoration: const BoxDecoration(
//               color: primaryColor,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             child: SvgPicture.asset("assets/icons/Search.svg"),
//           ),
//         ),
//       ),
//     );
//   }
// }