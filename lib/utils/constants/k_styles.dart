import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoist/utils/constants/color_constants.dart';
import 'package:todoist/utils/fonts/font_utils.dart';

class KStyle {
  KStyle._();

  ///Light theme
  static ThemeData getTheme() {
    final theme = ThemeData.light().withBaseTheme();
    return theme.copyWith(
      primaryColor: primaryColorLight,
      scaffoldBackgroundColor: scaffoldBackgroundLight,
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: appBarBackgroundLight,
        titleTextStyle: theme.appBarTheme.titleTextStyle!.copyWith(
          color: primaryColorLight,
        ),
        iconTheme: theme.iconTheme.copyWith(color: iconColorLight),
      ),
      indicatorColor: secondaryLight,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: bottomSheetBackgroundLight,
        modalBackgroundColor: modelBackgroundLight,
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryColorLight,
        secondary: secondaryLight,
        tertiary: tertiaryLight,
        onPrimary: onPrimaryLight,
        background: backgroundLight,
        onBackground: onBackgroundColorLight,
        surfaceVariant: primaryColorLight,
        onSurfaceVariant: onSurfaceVariantLight,
        onTertiary: onTertiaryLight,
        primaryContainer: primaryColorLight,
        tertiaryContainer: primaryColorLight,
        onSurface: onSurfaceLight,
        secondaryContainer: secondaryContainerLight,
        onSecondary: onSecondaryColorDark,
        error: errorLight,
        onError: onErrorLight,
        surface: surfaceColorLight,
        outline: surfaceColorLight,
      ),
      iconTheme: theme.iconTheme.copyWith(color: iconColorLight),
      listTileTheme: theme.listTileTheme.copyWith(iconColor: iconColorLight),
      dividerTheme: theme.dividerTheme.copyWith(
        color: dividerColorDark.withOpacity(0.2),
      ),
      bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
        selectedItemColor: secondaryLight,
        unselectedItemColor: unselectedColorLightBlueLight,
        backgroundColor: white,
        selectedIconTheme:
            theme.bottomNavigationBarTheme.selectedIconTheme!.copyWith(
          color: secondaryLight,
        ),
        unselectedIconTheme:
            theme.bottomNavigationBarTheme.unselectedIconTheme!.copyWith(
          color: unselectedColorLightBlueLight,
        ),
        selectedLabelStyle:
            theme.bottomNavigationBarTheme.selectedLabelStyle!.copyWith(
          color: secondaryLight,
        ),
        unselectedLabelStyle:
            theme.bottomNavigationBarTheme.unselectedLabelStyle!.copyWith(
          color: unselectedColorLightBlueLight,
        ),
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hintStyle: theme.textTheme.bodyMedium!.copyWith(
          color: unselectedColorLightBlueLight,
        ),
        labelStyle: theme.textTheme.bodyMedium!.copyWith(
          color: unselectedColorLightBlueLight,
        ),
        border: theme.inputDecorationTheme.border!.copyWith(
          borderSide: BorderSide(
            color: inputBorderColorLight.withOpacity(0.3),
          ),
        ),
        focusedBorder: theme.inputDecorationTheme.focusedBorder!.copyWith(
          borderSide: const BorderSide(color: inputBorderColorLight),
        ),
        enabledBorder: theme.inputDecorationTheme.focusedBorder!.copyWith(
          borderSide: BorderSide(
            color: inputBorderColorLight.withOpacity(0.5),
          ),
        ),
        errorBorder: theme.inputDecorationTheme.focusedBorder!.copyWith(
          borderSide: const BorderSide(color: errorColor),
        ),
        focusedErrorBorder: theme.inputDecorationTheme.focusedBorder!.copyWith(
          borderSide: const BorderSide(
            color: errorColor,
          ),
        ),
      ),
      cardTheme: theme.cardTheme.copyWith(
        color: cardBackgroundColorLight,
        surfaceTintColor: Colors.transparent,
      ),
      checkboxTheme: theme.checkboxTheme.copyWith(
        side: const BorderSide(color: Colors.black),
      ),
    );
  }

  ///dark theme
  static ThemeData getDarkTheme() {
    final theme = ThemeData.dark().withBaseTheme();

    return theme.copyWith(
      primaryColor: secondaryDark,
      scaffoldBackgroundColor: scaffoldBackgroundDark,
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: onSecondaryColorDark,
        titleTextStyle: theme.appBarTheme.titleTextStyle!.copyWith(
          color: white,
        ),
        iconTheme: theme.iconTheme.copyWith(color: iconColorDark),
      ),
      indicatorColor: secondaryDark,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: onSecondaryColorDark,
        modalBackgroundColor: onSecondaryColorDark,
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: primaryColorDark,
        secondary: secondaryDark,
        tertiary: tertiaryDark,
        onPrimary: onPrimaryDark,
        background: Colors.black.withOpacity(0.2),
        onBackground: white.withOpacity(0.15),
        surfaceVariant: surfaceVariantDark,
        onSurfaceVariant: white,
        onTertiary: onTertiaryDark,
        primaryContainer: primaryColorDark,
        tertiaryContainer: primaryColorDark,
        onSurface: onSurfaceDark,
        secondaryContainer: secondaryContainerDark,
        onSecondary: onSecondaryColorDark,
        error: errorDark,
        onError: onErrorDark,
        surface: surfaceColorLightDark,
        outline: surfaceColorLightDark,
      ),
      iconTheme: theme.iconTheme.copyWith(color: iconColorDark),
      listTileTheme: theme.listTileTheme.copyWith(iconColor: iconColorDark),
      bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
        backgroundColor: bottomNavigationBackgroundDark,
        selectedIconTheme:
            theme.bottomNavigationBarTheme.selectedIconTheme!.copyWith(
          color: secondaryLight,
        ),
        unselectedIconTheme:
            theme.bottomNavigationBarTheme.unselectedIconTheme!.copyWith(
          color: unselectedColorBlueDark,
        ),
        selectedLabelStyle:
            theme.bottomNavigationBarTheme.selectedLabelStyle!.copyWith(
          color: secondaryDark,
        ),
        unselectedLabelStyle:
            theme.bottomNavigationBarTheme.unselectedLabelStyle!.copyWith(
          color: unselectedColorBlueDark,
        ),
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hintStyle: theme.textTheme.bodyMedium!.copyWith(
          color: inputDecorationHintDark,
        ),
        labelStyle: theme.textTheme.bodyMedium!.copyWith(
          color: unselectedColorBlueDark,
        ),
        border: theme.inputDecorationTheme.border!.copyWith(
          borderSide: const BorderSide(color: inputDecorationBorderDark),
        ),
        focusedBorder: theme.inputDecorationTheme.focusedBorder!.copyWith(
          borderSide: const BorderSide(
            color: inputDecorationBorderFocusedDark,
          ),
        ),
        enabledBorder: theme.inputDecorationTheme.focusedBorder!.copyWith(
          borderSide: const BorderSide(
            color: inputDecorationBorderEnabledBorderDark,
          ),
        ),
        errorBorder: theme.inputDecorationTheme.focusedBorder!.copyWith(
          borderSide: const BorderSide(color: errorColor),
        ),
        focusedErrorBorder: theme.inputDecorationTheme.focusedBorder!.copyWith(
          borderSide: const BorderSide(
            color: inputBorderColorLight,
          ),
        ),
      ),
      dividerTheme: theme.dividerTheme.copyWith(
        color: dividerColorLight.withOpacity(0.2),
      ),
      checkboxTheme: theme.checkboxTheme.copyWith(
        side: const BorderSide(color: Colors.white),
      ),
      cardTheme: theme.cardTheme.copyWith(
        color: cardBackgroundColorDark,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}

TextTheme getDefaultTextTheme(String fontFamily) => TextTheme(
      ///Hug text Size 36
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 39.0.sp,
        letterSpacing: 0,
      ),

      ///Font Size 31 Font Weight 500
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 31.0.sp,
        letterSpacing: 0,
      ),

      ///Font Size 22 Font Weight 500
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 25.0.sp,
        letterSpacing: 0,
      ),

      ///Font Size 22 Font Weight 800
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 14.0.sp,
        letterSpacing: 0,
      ),

      ///Font Size 20 Font Weight 500
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 14.0.sp,
        letterSpacing: 0,
      ),

      ///Font Size 18 Font Weight 500
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 18.0.sp,
        letterSpacing: 0,
      ),

      ///Font Size 16 Font Weight 500
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 16.0.sp,
        letterSpacing: 0,
      ),

      ///Font Size 14 Font Weight 500
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 14.0.sp,
        letterSpacing: 0,
      ),

      ///Font Size 13 Font Weight 800
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w800,
        fontSize: 13.0.sp,
        letterSpacing: 0,
      ),
    );

extension ThemeDataEx on ThemeData {
  ThemeData withBaseTheme() {
    final fontFamily = FontUtils.getPrimaryFont();
    final defaultTextTheme = getDefaultTextTheme(fontFamily);
    return copyWith(
      primaryColor: primaryColorLight,
      scaffoldBackgroundColor: scaffoldBackgroundDark,
      appBarTheme: AppBarTheme(
        backgroundColor: onSecondaryColorDark,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          color: white, //for primary text color
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        elevation: 1,
        titleSpacing: 40,
        centerTitle: false,
      ),
      indicatorColor: secondaryLight,
      textTheme: textTheme.merge(defaultTextTheme),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: onSecondaryColorDark,
        modalBackgroundColor: onSecondaryColorDark,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: secondaryLight,
        unselectedItemColor: unselectedColorLightBlueLight,
        backgroundColor: black,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(
          size: 24.sp,
          color: secondaryLight,
        ),
        unselectedIconTheme: IconThemeData(
          size: 24.sp,
          color: unselectedColorLightBlueLight,
        ),
        selectedLabelStyle: defaultTextTheme.labelLarge!.copyWith(
          fontSize: 12.sp,
          color: secondaryLight,
        ),
        unselectedLabelStyle: defaultTextTheme.labelLarge!.copyWith(
          fontSize: 12.sp,
          color: unselectedColorLightBlueLight,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStatePropertyAll(Size(double.infinity, 56.h)),
          maximumSize: MaterialStatePropertyAll(Size(double.infinity, 56.h)),
          foregroundColor: const MaterialStatePropertyAll(white),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return primaryColorLight.withOpacity(0.05).withOpacity(0.38);
              }
              return primaryColorLight;
            },
          ),
          textStyle: MaterialStatePropertyAll(
            textTheme.bodyMedium!.copyWith(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          shape: MaterialStatePropertyAll(
            ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: secondaryLight,
          minimumSize: Size(double.infinity, 56.h),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          side: BorderSide(color: secondaryLight.withOpacity(0.6)),
          textStyle: TextStyle(
            fontFamily: FontUtils.getPrimaryFont(),
            color: Colors.white,
            fontSize: 16.sp,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: black,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 13.w,
          vertical: 19.h,
        ),
        hintStyle: defaultTextTheme.bodyMedium!.copyWith(
          color: unselectedColorLightBlueLight,
        ),
        labelStyle: defaultTextTheme.bodyMedium!.copyWith(
          color: unselectedColorLightBlueLight,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(color: white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(color: white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(color: white),
        ),
      ),
      cardTheme: cardTheme.copyWith(
        color: onSecondaryColorDark,
        surfaceTintColor: Colors.transparent,
      ),
      progressIndicatorTheme: progressIndicatorTheme.copyWith(
        linearTrackColor: primaryColorLight.withOpacity(0.5),
        color: primaryColorLight,
      ),
    );
  }
}
