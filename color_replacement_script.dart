// 顏色替換腳本 - 用於批量替換 main.dart 中的顏色使用
// 這個腳本列出了所有需要替換的顏色模式

// 1. 文字顏色替換
// Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6) -> AppColors.getSecondaryTextColor(context)
// Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5) -> AppColors.getHintTextColor(context)
// Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4) -> AppColors.getSubtleTextColor(context)
// Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7) -> AppColors.getSecondaryTextColor(context) (接近0.6)
// Theme.of(context).colorScheme.onSurface -> AppColors.getPrimaryTextColor(context)

// 2. 邊框顏色替換
// Theme.of(context).colorScheme.outline.withValues(alpha: 0.06) -> AppColors.getSubtleBorderColor(context)
// Theme.of(context).colorScheme.outline.withValues(alpha: 0.08) -> AppColors.getLightBorderColor(context)
// Theme.of(context).colorScheme.outline.withValues(alpha: 0.1) -> AppColors.getMediumBorderColor(context)
// Theme.of(context).colorScheme.outline.withValues(alpha: 0.12) -> AppColors.getStrongBorderColor(context)
// Theme.of(context).colorScheme.outline.withValues(alpha: 0.2) -> AppColors.getVeryStrongBorderColor(context)

// 3. 陰影顏色替換
// Theme.of(context).colorScheme.shadow.withValues(alpha: 0.08) -> AppColors.getLightShadowColor(context)
// Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1) -> AppColors.getMediumShadowColor(context)

// 4. 主要顏色替換
// Theme.of(context).colorScheme.primary -> AppColors.getPrimaryColor(context)
// Theme.of(context).colorScheme.secondary -> AppColors.getSecondaryColor(context)
// Theme.of(context).colorScheme.surface -> AppColors.getSurfaceColor(context)

// 5. 容器顏色替換
// Theme.of(context).colorScheme.primaryContainer -> AppColors.getPrimaryContainerColor(context)
// Theme.of(context).colorScheme.secondaryContainer -> AppColors.getSecondaryContainerColor(context)
// Theme.of(context).colorScheme.onPrimaryContainer -> AppColors.getOnPrimaryContainerColor(context)
// Theme.of(context).colorScheme.onSecondaryContainer -> AppColors.getOnSecondaryContainerColor(context)

// 6. 透明度顏色替換
// Theme.of(context).colorScheme.primary.withValues(alpha: 0.2) -> AppColors.getPrimaryLightColor(context)
// Theme.of(context).colorScheme.primary.withValues(alpha: 0.3) -> AppColors.getPrimaryMediumColor(context)
// Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3) -> AppColors.getSecondaryMediumColor(context)
// Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3) -> AppColors.getPrimaryContainerMediumColor(context)
// Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.3) -> AppColors.getSecondaryContainerMediumColor(context)

// 7. 文字顏色替換
// Theme.of(context).colorScheme.onPrimary -> AppColors.getOnPrimaryColor(context)
// Theme.of(context).colorScheme.onSecondary -> AppColors.getOnSecondaryColor(context)
