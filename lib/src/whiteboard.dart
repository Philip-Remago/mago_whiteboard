import 'package:flutter/material.dart';
import 'package:mago_widgets/mago_widgets.dart';

import 'toolbar.dart';

/// A whiteboard object that can be dragged on the surface.
class WhiteboardObject {
  WhiteboardObject({
    required this.id,
    required this.position,
    this.width = 200,
    this.height,
  });

  final String id;
  Offset position;
  double width;
  double? height;
}

class MagoWhiteboard extends StatefulWidget {
  const MagoWhiteboard({super.key, this.canvasSize = const Size(3840, 3840)});

  final Size canvasSize;

  @override
  State<MagoWhiteboard> createState() => _MagoWhiteboardState();
}

class _MagoWhiteboardState extends State<MagoWhiteboard> {
  final _canvasController = MagoCanvasController();
  final List<WhiteboardObject> _objects = [];
  final _dragSurfaceKey = GlobalKey<MagoDragSurfaceState<WhiteboardObject>>();

  double _strokeWidth = 4.0;
  double _eraserWidth = 20.0;
  Color _color = MagoColors.canvasColors[0];
  bool _isEraser = false;

  WhiteboardTool _currentTool = WhiteboardTool.hand;

  void _onToolSelected(WhiteboardTool tool) {
    setState(() {
      _currentTool = tool;
      _isEraser = tool == WhiteboardTool.eraser;
    });
  }

  @override
  void dispose() {
    _canvasController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // Scrollable canvas area
            InteractiveViewer(
              constrained: false,
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.1,
              maxScale: 4.0,
              child: SizedBox(
                width: widget.canvasSize.width,
                height: widget.canvasSize.height,
                child: Stack(
                  children: [
                    // Canvas layer
                    Positioned.fill(
                      child: MagoCanvas(
                        controller: _canvasController,
                        strokeWidth: () => _strokeWidth,
                        eraserWidth: () => _eraserWidth,
                        color: () => _color,
                        isEraser: () => _isEraser,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    // Drag surface layer
                    Positioned.fill(
                      child: MagoDragSurface<WhiteboardObject>(
                        key: _dragSurfaceKey,
                        items: _objects,
                        idOf: (obj) => obj.id,
                        itemBuilder:
                            (
                              context,
                              obj,
                              isSelected,
                              onSelectedChanged,
                              bringToFront,
                              onDragStateChanged,
                            ) {
                              return MagoDragObject(
                                position: obj.position,
                                width: obj.width,
                                height: obj.height,
                                isSelected: isSelected,
                                onSelectedChanged: onSelectedChanged,
                                onPositionChanged: (pos) {
                                  setState(() {
                                    obj.position = pos;
                                  });
                                },
                                onDragStart: () => onDragStateChanged(true),
                                onDragEnd: () => onDragStateChanged(false),
                                child:
                                    const SizedBox(), // Placeholder for future content
                              );
                            },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Toolbar at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Center(
                child: WhiteboardToolbar(
                  currentTool: _currentTool,
                  onToolSelected: _onToolSelected,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
