import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String role;
  final Widget? avatar;
  final VoidCallback? onEditName;
  final List<Color>? gradientColors;
  final Color? primaryColor;

  const ProfileHeader({
    super.key,
    this.name = '',
    this.role = 'Quiz Enthusiast',
    this.avatar,
    this.onEditName,
    this.gradientColors,
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ?? const [Color(0xFF4338CA), Color(0xFF4F46E5), Color(0xFF6366F1)];
    final badgeColor = primaryColor ?? const Color(0xFF4F46E5);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 65),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          // Avatar with optional edit badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1F000000),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(5),
                child:
                    avatar ??
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFEEF2FF),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 56,
                        color: Color(0xFF818CF8),
                      ),
                    ),
              ),
              if (onEditName != null)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: InkWell(
                    onTap: onEditName,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        size: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          // User Name with edit button or "Add Your Name" button
          if (name.trim().isEmpty)
            InkWell(
              onTap: onEditName,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.45),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.add_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Add Your Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            InkWell(
              onTap: onEditName,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                    if (onEditName != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.edit_rounded,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          const SizedBox(height: 4),
          // Subtitle / Bio
          Text(
            role,
            style: const TextStyle(
              color: Color(0xD8FFFFFF),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
