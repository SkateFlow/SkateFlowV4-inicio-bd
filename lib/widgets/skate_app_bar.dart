import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SkateAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final bool hasGradient;
  final double elevation;

  const SkateAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.hasGradient = true,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.lexend(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
      leading: leading,
      actions: actions,
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      flexibleSpace: hasGradient
          ? Container(
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// AppBar com scroll effect (como no design web)
class SkateScrollAppBar extends StatefulWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final ScrollController? scrollController;

  const SkateScrollAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.scrollController,
  });

  @override
  State<SkateScrollAppBar> createState() => _SkateScrollAppBarState();
}

class _SkateScrollAppBarState extends State<SkateScrollAppBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final isScrolled = widget.scrollController!.offset > 0;
    if (_isScrolled != isScrolled) {
      setState(() {
        _isScrolled = isScrolled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        gradient: _isScrolled ? AppTheme.primaryGradient : null,
        color: _isScrolled ? null : Colors.transparent,
      ),
      child: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.lexend(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        leading: widget.leading,
        actions: widget.actions,
        elevation: _isScrolled ? 4 : 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
    );
  }
}