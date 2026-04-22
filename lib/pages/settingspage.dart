import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:stemxplore/theme_provider.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  bool _isSound = false;

  final Color themeGreen = const Color.fromARGB(255, 52, 137, 55);
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildCustomAppBar(isEnglish),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Theme Mode Toggle
                settingsTile(
                  context: context,
                  leadingIcon: isDark ? Icons.dark_mode : Icons.light_mode,
                  iconColor: isDark
                      ? ThemeProvider.lightGreenBackground
                      : Theme.of(context).colorScheme.primary,
                  title: isEnglish ? "Theme Mode" : "Mod Tema",
                  subtitle: isEnglish
                      ? (isDark ? "Dark Mode" : "Light Mode")
                      : (isDark ? "Mod Gelap" : "Mod Terang"),
                  switchValue: isDark,
                  onSwitchChanged: (_) => themeProvider.toggleTheme(),
                ),

                const SizedBox(height: 20),

                // Sound / Mute Toggle
                settingsTile(
                  context: context,
                  leadingIcon: _isSound ? Icons.volume_off : Icons.volume_up,
                  iconColor: isDark
                      ? ThemeProvider.lightGreenBackground
                      : Theme.of(context).colorScheme.primary,
                  title: isEnglish ? "Mute" : "Senyap",
                  subtitle: null,
                  switchValue: _isSound,
                  onSwitchChanged: (val) => setState(() => _isSound = val),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable settings tile widget
  Widget settingsTile({
    required BuildContext context,
    required IconData leadingIcon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required bool switchValue,
    required Function(bool) onSwitchChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(leadingIcon, color: iconColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: Switch(
          value: switchValue,
          activeThumbColor: Theme.of(context).colorScheme.primary,
          onChanged: onSwitchChanged,
        ),
      ),
    );
  }

  AppBar buildCustomAppBar(bool isEnglish) {
    final theme = Theme.of(context);
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Side: App title with F3 badge
            Text(
              isEnglish ? "Info" : 'Maklumat',

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),

            // Right Side: Flag toggle (for display only now)
            GestureDetector(
              onTap: () {
                final FlutterLocalization localization =
                    FlutterLocalization.instance;

                final String currentLang =
                    localization.currentLocale?.languageCode ?? 'en';

                final String nextLocale = currentLang == 'en' ? 'ms' : 'en';

                localization.translate(nextLocale);

                setState(() {}); // rebuild UI
              },
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      // The flag changes based on isEnglish
                      isEnglish
                          ? 'assets/flag/language ms_flag.png'
                          : 'assets/flag/language us_flag.png',
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    isEnglish ? 'MS' : 'EN',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: theme.brightness == Brightness.dark
          ? Color.fromRGBO(179, 204, 161, 1)
          : Color.fromARGB(255, 52, 137, 55),
    );
  }

  Widget buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: themeGreen, size: 28),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
