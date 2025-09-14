import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_colors.dart';
import '../providers/accessibility_provider.dart';

class UIConstants {
  // Card styling
  static const double cardBorderRadius = 12.0;
  static const double cardElevation = 8.0;
  static const EdgeInsets cardMargin = EdgeInsets.symmetric(horizontal: 1, vertical: 6);
  static const EdgeInsets cardPadding = EdgeInsets.all(8);
  
  // Platform card specific
  static const double platformCardBorderRadius = 12.0;
  static const double platformCardElevation = 1.0;
  static const EdgeInsets platformCardMargin = EdgeInsets.symmetric(horizontal: 10, vertical: 5);
  
  // Compact card styling (for settings page)
  static const double compactCardBorderRadius = 12.0;
  static const EdgeInsets compactCardMargin = EdgeInsets.symmetric(vertical: 4);
  static const EdgeInsets compactCardPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 6);
  static const EdgeInsets compactSectionPadding = EdgeInsets.symmetric(horizontal: 4, vertical: 8);
  
  // Spacing constants
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 12.0;
  static const double spacingL = 16.0;
  static const double spacingXL = 24.0;
  static const double spacingXXL = 32.0;
  
  // Border radius constants
  static const double borderRadiusXS = 8.0;
  static const double borderRadiusS = 12.0;
  static const double borderRadiusM = 16.0;
  static const double borderRadiusL = 20.0;
  static const double borderRadiusXL = 24.0;
  
  // Icon sizes
  static const double iconSizeXS = 16.0;
  static const double iconSizeS = 20.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 28.0;
  static const double iconSizeXL = 32.0;
  
  // Color circle sizes (for theme selection)
  static const double colorCircleSizeS = 32.0;
  static const double colorCircleSizeM = 40.0;
  
  // ========================= Schedules 頁面統一樣式變數 =========================
  
  // 字體大小常數
  static const double fontSizeXS = 11.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 14.0;
  static const double fontSizeL = 16.0;
  static const double fontSizeXL = 18.0;
  static const double fontSizeXXL = 20.0;
  
  // 圓圈大小常數
  static const double circleSizeS = 48.0;
  static const double circleSizeM = 64.0;
  
  // 統一間距常數
  static const EdgeInsets scheduleCardMargin = EdgeInsets.symmetric(horizontal: 20, vertical: 6);
  
  // 統一邊框常數
  static const double borderWidth = 1.5;
  static const double borderWidthThin = 2.0;
  static const double borderWidthThick = 4.5;
  static const EdgeInsets scheduleCardPadding = EdgeInsets.all(10);
  static const EdgeInsets scheduleBadgePadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
  static const EdgeInsets scheduleListTilePadding = EdgeInsets.symmetric(horizontal: 20, vertical: 6);
  static const EdgeInsets scheduleSubtitlePadding = EdgeInsets.only(top: 4);
  
  // 統一圓角常數
  static const double scheduleCardBorderRadius = 20.0;
  static const double scheduleBadgeBorderRadius = 12.0;
  static const double scheduleIconBorderRadius = 10.0;
  
  // ========================= Routes 頁面統一樣式變數 =========================
  
  // Routes 頁面間距常數
  static const EdgeInsets routesSelectorMargin = EdgeInsets.symmetric(horizontal: 1, vertical: 1);
  static const EdgeInsets routesSelectorPadding = EdgeInsets.all(1);
  static const EdgeInsets routesChipPadding = EdgeInsets.symmetric(horizontal: 1, vertical: 1);
  static const EdgeInsets routesCompactChipPadding = EdgeInsets.symmetric(horizontal: 1, vertical: 1);
  static const EdgeInsets routesWarningPadding = EdgeInsets.all(1);
  static const EdgeInsets routesWarningChipPadding = EdgeInsets.symmetric(horizontal: 1, vertical: 6);
  
  // Routes 頁面圓角常數
  static const double routesSelectorBorderRadius = 20.0;
  static const double routesWarningBorderRadius = 12.0;
  static const double routesWarningChipBorderRadius = 12.0;
  
  // ========================= Settings 頁面統一樣式變數 =========================
  
  // Settings 頁面間距常數
  static const EdgeInsets settingsPagePadding = EdgeInsets.symmetric(horizontal: 20, vertical: 6);
  static const EdgeInsets settingsSliderPadding = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets settingsChoiceChipPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
  
  // Settings 頁面圓角常數
  static const double settingsChoiceChipBorderRadius = 12.0;
  
  // 統一樣式方法
  static TextStyle scheduleTitleStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontSize: fontSizeL * accessibility.textScale,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white.withValues(alpha: 0.87)
          : null,
    );
  }
  
  static TextStyle scheduleSubtitleStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontSize: fontSizeM * accessibility.textScale,
      color: AppColors.getPrimaryTextColor(context),
    );
  }
  
  static TextStyle scheduleBodyStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontSize: fontSizeM * accessibility.textScale,
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white.withValues(alpha: 0.70)
          : null,
    );
  }
  
  static TextStyle scheduleCaptionStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontSize: fontSizeS * accessibility.textScale,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
    );
  }
  
  static TextStyle scheduleErrorStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontSize: fontSizeS * accessibility.textScale,
      color: Colors.red,
      fontWeight: FontWeight.w500,
    );
  }
  
  static TextStyle scheduleRouteHeaderStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontSize: fontSizeXXL * accessibility.textScale,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white.withValues(alpha: 0.87)
          : null,
    );
  }
  
  static TextStyle scheduleStationNameStyle(BuildContext context, AccessibilityProvider accessibility) {
    return Theme.of(context).textTheme.titleMedium?.copyWith(
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white.withValues(alpha: 0.87)
          : null,
      fontWeight: FontWeight.w600,
      fontSize: fontSizeL * accessibility.textScale,
    ) ?? TextStyle(
      fontSize: fontSizeL * accessibility.textScale,
      fontWeight: FontWeight.w600,
    );
  }
  
  static TextStyle scheduleTrainNameStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSizeL * accessibility.textScale,
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white.withValues(alpha: 0.87)
          : null,
    );
  }
  
  static TextStyle scheduleBadgeStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: fontSizeS * accessibility.textScale,
      fontWeight: FontWeight.w500,
    );
  }
  
  static TextStyle scheduleNoDataStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontSize: fontSizeXL * accessibility.textScale,
      color: AppColors.getPrimaryTextColor(context),
    );
  }
  
  // 統一陰影
  static List<BoxShadow> scheduleCardShadow(BuildContext context) {
    return [
      BoxShadow(
        color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.4),
        blurRadius: 4,
        offset: const Offset(0, 1),
        spreadRadius: 1.5,
      ),
    ];
  }
  
  // 統一邊框
  static Border scheduleCardBorder(BuildContext context) {
    return Border.all(
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 1),
      width: UIConstants.borderWidth,
    );
  }
  
  static Border scheduleListTileBorder(BuildContext context) {
    return Border(
      bottom: BorderSide(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.08),
        width: UIConstants.borderWidth,
      ),
    );
  }
  
  // 統一背景色
  static Color scheduleHeaderBackground(BuildContext context) {
    return Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 1);
  }
  
  static Color scheduleErrorBackground(BuildContext context) {
    return Colors.red.withValues(alpha: 0.1);
  }
  
  static Color scheduleErrorBorder(BuildContext context) {
    return Colors.red.withValues(alpha: 0.3);
  }
  
  // 統一圖標大小
  static double scheduleIconSize(BuildContext context, AccessibilityProvider accessibility, {double multiplier = 1.0}) {
    return iconSizeS * accessibility.iconScale * multiplier;
  }
  
  static double scheduleLargeIconSize(BuildContext context, AccessibilityProvider accessibility) {
    return circleSizeM * accessibility.iconScale;
  }
  
  // Routes 頁面陰影
  static List<BoxShadow> routesSelectorShadow(BuildContext context) {
    return [
      BoxShadow(
        color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
        blurRadius: 4,
        offset: const Offset(0, 1),
        spreadRadius: 5,
      ),
    ];
  }
  
  // Routes 頁面邊框
  static Border routesSelectorBorder(BuildContext context) {
    return Border.all(
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.08),
      width: UIConstants.borderWidth,
    );
  }
  
  static Border routesWarningBorder(BuildContext context) {
    return Border.all(
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.08),
      width: UIConstants.borderWidth,
    );
  }
  
  static Border routesWarningChipBorder(BuildContext context) {
    return Border.all(
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.08),
      width: UIConstants.borderWidth,
    );
  }
  
  // Routes 頁面背景色
  static Color routesWarningBackground(BuildContext context) {
    return Colors.orange.withValues(alpha: 0.1);
  }
  
  // Routes 頁面樣式方法
  static TextStyle routesLabelStyle(BuildContext context) {
    return TextStyle(
      fontSize: fontSizeM * context.watch<AccessibilityProvider>().textScale,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white.withValues(alpha: 0.87)
          : null,
    );
  }
  
  static TextStyle routesDistrictChipStyle(BuildContext context, AccessibilityProvider accessibility, bool isSelected) {
    return TextStyle(
      fontSize: fontSizeS * accessibility.textScale,
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white.withValues(alpha: 0.87)
          : null,
    );
  }
  
  static TextStyle routesRouteChipStyle(BuildContext context, AccessibilityProvider accessibility, bool isSelected) {
    return TextStyle(
      fontSize: fontSizeXS * accessibility.textScale,
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white.withValues(alpha: 0.87)
          : null,
    );
  }
  
  static TextStyle routesDescriptionStyle(BuildContext context) {
    return TextStyle(
      fontSize: fontSizeM * context.watch<AccessibilityProvider>().textScale,
      color: AppColors.getPrimaryTextColor(context),
    );
  }
  
  static TextStyle routesWarningTitleStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontSize: fontSizeL * accessibility.textScale,
      fontWeight: FontWeight.w600,
      color: Colors.orange,
    );
  }
  
  static TextStyle routesWarningChipStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontSize: fontSizeS * accessibility.textScale,
      color: Colors.orange,
    );
  }
  
  // Routes 頁面圖標大小
  static double routesWarningIconSize(BuildContext context, AccessibilityProvider accessibility) {
    return iconSizeS * accessibility.iconScale;
  }
  
  // Settings 頁面樣式方法
  static TextStyle settingsCardTitleStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontSize: fontSizeM * accessibility.textScale,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white.withValues(alpha: 0.87)
          : null,
    );
  }
  
  static TextStyle settingsCardSubtitleStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontSize: fontSizeS * accessibility.textScale,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
    );
  }
  
  static TextStyle settingsSectionTitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: fontSizeL * context.watch<AccessibilityProvider>().textScale,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white.withValues(alpha: 0.87)
          : null,
    );
  }
  
  static TextStyle settingsSliderLabelStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontSize: fontSizeS * accessibility.textScale,
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white.withValues(alpha: 0.70)
          : null,
    );
  }
  
  static TextStyle settingsChoiceChipLabelStyle(BuildContext context, AccessibilityProvider accessibility) {
    return TextStyle(
      fontSize: fontSizeS * accessibility.textScale,
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white.withValues(alpha: 0.70)
          : null,
    );
  }
  
  // Settings 頁面圖標大小
  static double settingsIconSize(BuildContext context, AccessibilityProvider accessibility) {
    return iconSizeS * accessibility.iconScale;
  }
  
  static double settingsLargeIconSize(BuildContext context, AccessibilityProvider accessibility) {
    return iconSizeL * accessibility.iconScale;
  }
  
  static List<BoxShadow> cardShadow(BuildContext context) {
    return [
      BoxShadow(
        color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.04),
        blurRadius: 4,
        offset: const Offset(0, 1),
        spreadRadius: 0,
      ),
    ];
  }
  
  static List<BoxShadow> compactCardShadow(BuildContext context) {
    return [
      BoxShadow(
        color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.04),
        blurRadius: 4,
        offset: const Offset(0, 1),
        spreadRadius: 0,
      ),
    ];
  }
  
  static List<BoxShadow> elevatedCardShadow(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: isDark 
            ? Colors.black.withValues(alpha: 0.4)
            : Colors.grey.withValues(alpha: 0.2),
        blurRadius: 12,
        offset: const Offset(0, 4),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: isDark 
            ? Colors.black.withValues(alpha: 0.2)
            : Colors.grey.withValues(alpha: 0.1),
        blurRadius: 6,
        offset: const Offset(0, 2),
        spreadRadius: 0,
      ),
    ];
  }
  
  static List<BoxShadow> colorCircleShadow(BuildContext context, Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.3),
        blurRadius: 4,
        spreadRadius: 1,
      ),
    ];
  }

  static double getAdaptiveIconSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 428; // Assuming 428 is the width of the iPhone 12 Pro Max
    return baseSize * scaleFactor;
  }
}