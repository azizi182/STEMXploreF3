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
        appBar: buildCustomAppBar(isEnglish, context),
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

  AppBar buildCustomAppBar(bool isEnglish, BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Text(
          isEnglish ? "Settings" : 'Tetapan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: theme.brightness == Brightness.dark
                ? Colors.black
                : Colors.black,
          ),
        ),
      ),
      backgroundColor: theme.brightness == Brightness.dark
          ? Color.fromRGBO(179, 204, 161, 1)
          : Color.fromARGB(255, 52, 137, 55),
      actions: [
        GestureDetector(
          onTap: () {
            final localization = FlutterLocalization.instance;

            final currentLang =
                localization.currentLocale?.languageCode ?? 'en';
            final newLang = currentLang == 'en' ? 'ms' : 'en';

            localization.translate(newLang);

            setState(() {});
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔵 Circle (ONLY flag inside)
              Container(
                padding: const EdgeInsets.all(12),

                child: ClipOval(
                  child: Image.asset(
                    isEnglish
                        ? 'assets/flag/language ms_flag.png'
                        : 'assets/flag/language us_flag.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // 🔤 Text BELOW the circle
              Text(
                isEnglish ? 'MS' : 'EN',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
