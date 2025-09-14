import 'package:flutter/material.dart';

/// 統一的顏色方案類別 - 確保整個應用程式的顏色一致性
class AppColors {
  // 透明度常數 - 統一的透明度值
  static const double _primaryOpacity = 0.6;
  static const double _secondaryOpacity = 0.6;
  static const double _hintOpacity = 0.5;
  static const double _disabledOpacity = 0.38;
  static const double _subtleOpacity = 0.4;
  static const double _verySubtleOpacity = 0.2;
  
  // 邊框和陰影透明度
  static const double _borderSubtleOpacity = 0.06;
  static const double _borderLightOpacity = 0.08;
  static const double _borderMediumOpacity = 0.1;
  static const double _borderStrongOpacity = 0.12;
  static const double _borderVeryStrongOpacity = 0.2;
  
  // 陰影透明度
  static const double _shadowLightOpacity = 0.08;
  static const double _shadowMediumOpacity = 0.1;
  
  // 容器透明度
  static const double _containerLightOpacity = 0.2;
  static const double _containerMediumOpacity = 0.3;
  
  // 主要文字顏色
  static Color getPrimaryTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: _primaryOpacity);
  }
  
  // 次要文字顏色
  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: _secondaryOpacity);
  }
  
  // 提示文字顏色
  static Color getHintTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: _hintOpacity);
  }
  
  // 禁用文字顏色
  static Color getDisabledTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: _disabledOpacity);
  }
  
  // 微妙文字顏色
  static Color getSubtleTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: _subtleOpacity);
  }
  
  // 非常微妙文字顏色
  static Color getVerySubtleTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: _verySubtleOpacity);
  }
  
  // 邊框顏色
  static Color getSubtleBorderColor(BuildContext context) {
    return Theme.of(context).colorScheme.outline.withValues(alpha: _borderSubtleOpacity);
  }
  
  static Color getLightBorderColor(BuildContext context) {
    return Theme.of(context).colorScheme.outline.withValues(alpha: _borderLightOpacity);
  }
  
  static Color getMediumBorderColor(BuildContext context) {
    return Theme.of(context).colorScheme.outline.withValues(alpha: _borderMediumOpacity);
  }
  
  static Color getStrongBorderColor(BuildContext context) {
    return Theme.of(context).colorScheme.outline.withValues(alpha: _borderStrongOpacity);
  }
  
  static Color getVeryStrongBorderColor(BuildContext context) {
    return Theme.of(context).colorScheme.outline.withValues(alpha: _borderVeryStrongOpacity);
  }
  
  // 陰影顏色
  static Color getLightShadowColor(BuildContext context) {
    return Theme.of(context).colorScheme.shadow.withValues(alpha: _shadowLightOpacity);
  }
  
  static Color getMediumShadowColor(BuildContext context) {
    return Theme.of(context).colorScheme.shadow.withValues(alpha: _shadowMediumOpacity);
  }
  
  // 容器顏色
  static Color getLightContainerColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface.withValues(alpha: _containerLightOpacity);
  }
  
  static Color getMediumContainerColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface.withValues(alpha: _containerMediumOpacity);
  }
  
  // 狀態顏色
  static Color getSuccessColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }
  
  static Color getWarningColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }
  
  static Color getErrorColor(BuildContext context) {
    return Theme.of(context).colorScheme.error;
  }
  
  // 平台特定顏色
  static Color getPlatformColor(BuildContext context) {
    return Theme.of(context).colorScheme.tertiary;
  }
  
  // 路線顏色
  static Color getRouteColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }
  
  // 目的地顏色
  static Color getDestinationColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }
  
  // 時間顏色
  static Color getTimeColor(BuildContext context) {
    return Theme.of(context).colorScheme.tertiary;
  }
  
  // 列車長度顏色
  static Color getTrainLengthColor(BuildContext context) {
    return Theme.of(context).colorScheme.outline;
  }
  
  // 狀態指示器顏色
  static Color getStatusNormalColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }
  
  static Color getStatusAlertColor(BuildContext context) {
    return Theme.of(context).colorScheme.error;
  }
  
  static Color getStatusSystemColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }
  
  // 背景顏色變體
  static Color getCardBackgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }
  
  static Color getListTileBackgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceVariant;
  }
  
  static Color getSelectedBackgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.primaryContainer;
  }
  
  static Color getHoverBackgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceVariant;
  }
  
  // 按鈕顏色
  static Color getButtonBackgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }
  
  static Color getButtonTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onPrimary;
  }
  
  static Color getSecondaryButtonBackgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }
  
  static Color getSecondaryButtonTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSecondary;
  }
  
  // 輸入框顏色
  static Color getInputBackgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }
  
  static Color getInputBorderColor(BuildContext context) {
    return Theme.of(context).colorScheme.outline;
  }
  
  static Color getInputFocusedBorderColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }
  
  // 分割線顏色
  static Color getDividerColor(BuildContext context) {
    return Theme.of(context).colorScheme.outline.withValues(alpha: 0.12);
  }
  
  // 圖標顏色
  static Color getIconColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }
  
  static Color getIconSecondaryColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);
  }
  
  // 進度指示器顏色
  static Color getProgressIndicatorColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }
  
  // 標籤顏色
  static Color getChipBackgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceVariant;
  }
  
  static Color getChipTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurfaceVariant;
  }
  
  // 徽章顏色
  static Color getBadgeBackgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.error;
  }
  
  static Color getBadgeTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onError;
  }
}