import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/list_quran/componant/custom_list_tile.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.7,
      child: Container(
        color: Colors.black87, // Background color
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.12,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black87,
                ),
                child: Text(
                  'طريقة عرض المصحف',
                  style: TextStyle(
                    color: Colors.white,
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
                        side: const BorderSide(color: Colors.blue),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        'المصحف الأفقي',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        backgroundColor: Colors.black87,
                      ),
                      child: const Text(
                        'المصحف الرأسي',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey),

            
            // List items
            const CustomListTile(
                title: 'المصحف', icon: Icons.book, isHeader: true),
            const CustomListTile(title: 'الفهرس', icon: Icons.list_alt),
            const CustomListTile(title: 'البحث', icon: Icons.search),
            Container(
                color: Colors.red[800],
                padding: const EdgeInsets.all(8.0),
                child: const Text('ألخصائص',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))),
            const CustomListTile(title: 'الترجمة', icon: Icons.translate),
            const CustomListTile(title: 'التفسير', icon: Icons.library_books),
            const CustomListTile(title: 'المعاني', icon: Icons.notes),
            const CustomListTile(title: 'الصوتيات', icon: Icons.volume_up),
            const CustomListTile(
                title: 'التصفح التلقائي', icon: Icons.auto_mode),
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                final isDark = state.themeData == ThemeData.dark();

                return CustomListTile(
                    title: isDark ? 'الوضع النهاري' : 'الوضع الليلي',
                    icon: Icons.nightlight_round,
                    trailing: Switch(
                      value: isDark,
                      onChanged: (value) {
                        context.read<ThemeCubit>().toggleTheme(value); //
                      },
                      activeColor: isDark ? Colors.black : Colors.black,
                      inactiveThumbColor: isDark ? Colors.white : Colors.black,
                      inactiveTrackColor: Colors.white,
                      activeTrackColor: Colors.white,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
