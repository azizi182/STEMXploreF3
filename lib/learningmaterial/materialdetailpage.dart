import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:stemxplore/database/dao/bookmark_dao.dart';
import 'package:stemxplore/database/db_helper.dart';
import 'package:stemxplore/theme_provider.dart';
import 'package:stemxplore/bookmarkmanager.dart';

class Materialdetailpage extends StatelessWidget {
  final Map learningMaterial;

  const Materialdetailpage({super.key, required this.learningMaterial});

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish =
        (localization.currentLocale?.languageCode ?? 'en') == 'en';

    final String title = isEnglish
        ? (learningMaterial['learning_title_en']?.toString() ?? '')
        : (learningMaterial['learning_title_ms']?.toString() ?? '');

    return GradientBackground(
      child: Scaffold(
        appBar: _buildAppBar(context, isEnglish, title),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 100, 8, 20),
          child: Column(
            children: List.generate(learningMaterial['pages'].length, (index) {
              final page = learningMaterial['pages'][index];
              return _PageItem(page: page);
            }),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, bool isEnglish, String title) {
    final theme = Theme.of(context);
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                final localization = FlutterLocalization.instance;
                final currentLang =
                    localization.currentLocale?.languageCode ?? 'en';
                final newLang = currentLang == 'en' ? 'ms' : 'en';
                localization.translate(newLang);
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
}

class _PageItem extends StatefulWidget {
  final Map page;

  const _PageItem({required this.page});

  @override
  State<_PageItem> createState() => _PageItemState();
}

class _PageItemState extends State<_PageItem> {
  Future<bool> _isBookmarked() async {
    final db = await DBHelper.getDB();
    final result = await db.query(
      'stem_learning_page',
      where: 'page_id = ? AND bookmark = ?',
      whereArgs: [widget.page['page_id'], 'yes'],
    );
    return result.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish =
        (localization.currentLocale?.languageCode ?? 'en') == 'en';

    final description = isEnglish
        ? widget.page['page_desc_en'] ?? ''
        : widget.page['page_desc_ms'] ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER + BOOKMARK ICON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  isEnglish
                      ? (widget.page['page_title_en'] ?? '')
                      : (widget.page['page_title_ms'] ?? ''),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /// ✅ FUTURE BUILDER HERE
              FutureBuilder<bool>(
                future: _isBookmarked(),
                builder: (context, snapshot) {
                  final isBookmarked = snapshot.data ?? false;

                  return IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.green,
                    ),
                    onPressed: () async {
                      /// toggle bookmark in DB
                      await LearningPageDao.updateBookmark(
                        widget.page['page_id'],
                        isBookmarked ? 'no' : 'yes',
                      );

                      /// refresh THIS widget only
                      setState(() {});

                      /// popup
                      if (context.mounted) {
                        _showBookmarkPopup(
                          context,
                          isAdding: !isBookmarked,
                          isEnglish: isEnglish,
                          isDark:
                              Theme.of(context).brightness == Brightness.dark,
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// MEDIA
          Column(
            children: ((widget.page['media'] as List?) ?? []).map<Widget>((
              media,
            ) {
              final m = Map<String, dynamic>.from(media);

              if (m['type'] == 'image') {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImagePage(imageUrl: m['url']),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(m['url'], fit: BoxFit.cover),
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            }).toList(),
          ),

          /// DESCRIPTION
          Text(
            description,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

void _showBookmarkPopup(
  BuildContext context, {
  required bool isAdding,
  required bool isEnglish,
  required bool isDark,
}) {
  showDialog(
    context: context,
    // ignore: deprecated_member_use
    barrierColor: Colors.black.withOpacity(0.3),
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF3D3D3D) : Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isAdding ? Icons.bookmark_added : Icons.bookmark_remove,
                size: 55,
                color: const Color(0xFF4CAF50),
              ),
              const SizedBox(height: 16),

              Text(
                isAdding
                    ? (isEnglish
                          ? "Bookmarked successfully"
                          : "Berjaya ditanda buku")
                    : (isEnglish ? "Bookmark removed" : "Penanda buku dibuang"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImagePage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              maxScale: 5.0, // allow pinch zoom
              child: Image.asset(
                imageUrl,
                fit: BoxFit.contain,

                errorBuilder: (context, error, stack) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              iconSize: 35,
              color: Colors.white,
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
