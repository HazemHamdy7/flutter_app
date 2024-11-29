import 'package:flutter/material.dart';
import 'package:flutter_app/constants/app_colors.dart';
import 'package:flutter_app/features/Quran/list_quran/componant/custom_list_tile.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        context.watch<ThemeCubit>().state.themeData == ThemeData.dark();
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.7,
      child: Container(
        color: isDark ? AppColors.white : AppColors.black, // Background color
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.12,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: isDark ? Colors.white : Colors.black,
                ),
                child: Text(
                  'طريقة عرض المصحف',
                  style: TextStyle(
                    color: isDark ? AppColors.black : AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side:   BorderSide(color: AppColors.white),
                        backgroundColor: Colors.black87,
                      ),
                      child:   Text(
                        'المصحف الأفقي',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side:   BorderSide(color: AppColors.white),
                        backgroundColor: Colors.black87,
                      ),
                      child:   Text(
                        'المصحف الرأسي',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey),

            // List items
            CustomListTile(
                color: isDark ? AppColors.black : AppColors.white,
                title: 'المصحف',
                icon: Icons.book,
                isHeader: true),
            CustomListTile(
                title: 'الفهرس',
                color: isDark ? AppColors.black : AppColors.white,
                icon: Icons.list_alt),
            CustomListTile(
                title: 'البحث',
                color: isDark ? AppColors.black : Colors.white,
                icon: Icons.search),
            Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.all(8.0),
                child: Text('ألخصائص',
                    style: TextStyle(
                        color: isDark ? AppColors.black : AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))),
            CustomListTile(
                title: 'الترجمة',
                color: isDark ? AppColors.black : AppColors.white,
                icon: Icons.translate),
            CustomListTile(
                title: 'التفسير',
                color: isDark ? AppColors.black : AppColors.white,
                icon: Icons.library_books),
            CustomListTile(
                title: 'المعاني',
                color: isDark ? AppColors.black : AppColors.white,
                icon: Icons.notes),
            CustomListTile(
                title: 'الصوتيات',
                color: isDark ? AppColors.black : AppColors.white,
                icon: Icons.volume_up),
            CustomListTile(
                title: 'التصفح التلقائي',
                color: isDark ? AppColors.black : AppColors.white,
                icon: Icons.auto_mode),
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                final isDark = state.themeData == ThemeData.dark();

                return CustomListTile(
                    title: isDark ? 'الوضع النهاري' : 'الوضع الليلي',
                    color: isDark ? AppColors.black : AppColors.white,
                    icon: Icons.nightlight_round,
                    trailing: Switch(
                      value: isDark,
                      onChanged: (value) {
                        context.read<ThemeCubit>().toggleTheme(value); //
                      },
                      activeColor: isDark ? AppColors.black : AppColors.black,
                      inactiveThumbColor: isDark ? AppColors.white : AppColors.black,
                      inactiveTrackColor: AppColors.white,
                      activeTrackColor: AppColors.white,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
