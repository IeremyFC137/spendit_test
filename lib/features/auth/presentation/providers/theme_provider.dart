import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spendit_test/config/theme/app_theme.dart';

import '../../../shared/shared.dart';

final colorListProvider = Provider((ref) => colorList);

final nameListProvider = Provider((ref) => nameList);

final isDarkModeProvider = StateProvider((ref) => false);

final selectedColorProvider = StateProvider((ref) => 0);

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(AppTheme()),
);

class ThemeNotifier extends StateNotifier<AppTheme> {
  final keyValueStorageService = KeyValueStorageServiceImpl();

  ThemeNotifier(AppTheme initialTheme) : super(initialTheme);

  void toggleDarkmode() async {
    final newIsDarkmode = !state.isDarkmode;
    await keyValueStorageService.setKeyValue('isDarkMode', newIsDarkmode);
    state = state.copyWith(isDarkmode: newIsDarkmode);
  }

  void changeColorIndex(int colorIndex) async {
    await keyValueStorageService.setKeyValue('colorTheme', colorIndex);
    state = state.copyWith(selectedColor: colorIndex);
  }
}
