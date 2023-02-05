import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/branch/branch_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/get_consumeable_deyails/get_consumeable_details_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/patch_consumable_details/consumable_patch_bloc.dart';
import 'package:ots_pocket/bloc/equipment/add_new_equipment/add_new_equipment_bloc.dart';
import 'package:ots_pocket/bloc/equipment/get_equipments_deyails/get_equipments_details_bloc.dart';
import 'package:ots_pocket/bloc/equipment/patch_equipments_details/equipments_patch_bloc.dart';
import 'package:ots_pocket/bloc/login/login_bloc.dart';
import 'package:ots_pocket/bloc/user/get_loggedin_user_details/get_loggedin_user_details_bloc.dart';
import 'package:ots_pocket/bloc/user/get_user_details/get_user_details_bloc.dart';
import 'package:ots_pocket/bloc/user/patch_User_details/user_patch_bloc.dart';
import 'package:ots_pocket/bloc/user/registration/registration_bloc.dart';
import 'package:ots_pocket/config/stroage.dart';
import 'package:ots_pocket/config/repo_factory.dart';
import 'package:ots_pocket/splash_screen.dart';

import 'bloc/laborRate/getLaborRate/get_labor_rate_bloc.dart';
import 'bloc/user/delete_User/user_delete_bloc.dart';

final EncryptedSharedPrefManager? appStorage =
    EncryptedSharedPrefManager.getInstance();

void main() async {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BranchBloc(
            repoFactory: RepoFactory(),
          ),
        ),
        BlocProvider(
          create: (context) => UserRegistrationBloc(
            repoFactory: RepoFactory(),
          ),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            repoFactory: RepoFactory(),
          ),
        ),
        BlocProvider(
          create: (context) => GetUserDetailsUserBloc(
            repoFactory: RepoFactory(),
          ),
        ),
        BlocProvider(
          create: (context) => GetLoggedinUserDetailsBloc(
            repoFactory: RepoFactory(),
          ),
        ),
        BlocProvider(
          create: (context) => UserPatchBloc(
            repoFactory: RepoFactory(),
          ),
        ),
        BlocProvider(
          create: (context) => GetConsumableBloc(
            repoFactory: RepoFactory(),
          ),
        ),
        BlocProvider(
          create: (context) => ConsumablePatchBloc(
            repoFactory: RepoFactory(),
          ),
        ),
        BlocProvider(
          create: (context) => GetEqupmentsBloc(
            repoFactory: RepoFactory(),
          ),
        ),
        BlocProvider(
          create: (context) => EquipmentPatchBloc(
            repoFactory: RepoFactory(),
          ),
        ),
        BlocProvider(
          create: (context) => AddNewConsumeableBloc(
            repoFactory: RepoFactory(),
          ),
        ),
        BlocProvider(
          create: (context) => AddNewEquipmentBloc(
            repoFactory: RepoFactory(),
          ),
        ),
        BlocProvider(
          create: (context) => UserDeleteBloc(
            repoFactory: RepoFactory(),
          ),
        ),
        BlocProvider(
          create: (context) => GetLaborRateBloc(
            repoFactory: RepoFactory(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTS Pocket',
      theme: ThemeData(
        primaryColor: Color(0xFF157B4F),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
