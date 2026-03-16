import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mago_widgets/mago_widgets.dart';

enum WhiteboardTool {
  hand,
  pencil,
  highlighter,
  eraser,
  lassoSelect,
  stickyNote,
  type,
  shapes,
  plus,
}

class WhiteboardToolbar extends StatelessWidget {
  const WhiteboardToolbar({
    super.key,
    required this.currentTool,
    required this.onToolSelected,
  });

  final WhiteboardTool currentTool;
  final ValueChanged<WhiteboardTool> onToolSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassContainer(
      borderRadius: BorderRadius.circular(12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ToolButton(
            icon: LucideIcons.hand,
            isSelected: currentTool == WhiteboardTool.hand,
            onTap: () => onToolSelected(WhiteboardTool.hand),
          ),
          _ToolButton(
            icon: LucideIcons.pencil,
            isSelected: currentTool == WhiteboardTool.pencil,
            onTap: () => onToolSelected(WhiteboardTool.pencil),
          ),
          _ToolButton(
            icon: LucideIcons.highlighter,
            isSelected: currentTool == WhiteboardTool.highlighter,
            onTap: () => onToolSelected(WhiteboardTool.highlighter),
          ),
          _ToolButton(
            icon: LucideIcons.eraser,
            isSelected: currentTool == WhiteboardTool.eraser,
            onTap: () => onToolSelected(WhiteboardTool.eraser),
          ),
          _ToolButton(
            icon: LucideIcons.lassoSelect,
            isSelected: currentTool == WhiteboardTool.lassoSelect,
            onTap: () => onToolSelected(WhiteboardTool.lassoSelect),
          ),
          _ToolButton(
            icon: LucideIcons.stickyNote,
            isSelected: currentTool == WhiteboardTool.stickyNote,
            onTap: () => onToolSelected(WhiteboardTool.stickyNote),
          ),
          _ToolButton(
            icon: LucideIcons.type,
            isSelected: currentTool == WhiteboardTool.type,
            onTap: () => onToolSelected(WhiteboardTool.type),
          ),
          _ToolButton(
            icon: LucideIcons.shapes,
            isSelected: currentTool == WhiteboardTool.shapes,
            onTap: () => onToolSelected(WhiteboardTool.shapes),
          ),
          _ToolButton(
            icon: LucideIcons.plus,
            isSelected: currentTool == WhiteboardTool.plus,
            onTap: () => onToolSelected(WhiteboardTool.plus),
          ),
        ],
      ),
    );
  }
}

class _ToolButton extends StatelessWidget {
  const _ToolButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: isSelected
          ? colorScheme.primary.withAlpha(30)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 22,
            color: isSelected ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
