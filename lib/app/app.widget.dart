import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../core/router/app.router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'Mini Universidad',

      themeMode: ThemeMode.system,

      // LIGHT THEME
      theme: FlexThemeData.light(
        scheme: FlexScheme.blueM3,
        useMaterial3: true,

        visualDensity: FlexColorScheme.comfortablePlatformDensity,

        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 8,

        appBarElevation: 0,
        transparentStatusBar: true,

        subThemesData: const FlexSubThemesData(
          // Bordes redondeados globales
          defaultRadius: 22,

          // Inputs modernos
          inputDecoratorIsFilled: true,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorRadius: 16,

          // Cards
          cardRadius: 20,

          // Botones flotantes
          fabUseShape: true,

          // Efectos visuales
          interactionEffects: true,

          // Mejor contraste
          blendOnLevel: 10,
          blendOnColors: false,
        ),
      ),

      // DARK THEME
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.blueM3,
        useMaterial3: true,

        visualDensity: FlexColorScheme.comfortablePlatformDensity,

        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 12,

        appBarElevation: 0,
        transparentStatusBar: true,

        subThemesData: const FlexSubThemesData(
          defaultRadius: 22,

          inputDecoratorIsFilled: true,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorRadius: 16,

          cardRadius: 20,

          fabUseShape: true,

          interactionEffects: true,

          blendOnLevel: 12,
          blendOnColors: false,
        ),
      ),
    );
  }
}
