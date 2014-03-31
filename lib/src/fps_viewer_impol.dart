library fps_viewer_impl;
import 'dart:html';

abstract class FpsDisplay {
  /*
   * Creates a box on the page with the current FPS
   */
  
}

class DisplayFps implements FpsDisplay{
  /// Display the animation's FPS in a div.
  var fps = new DivElement();
  
  num fpsAverage;
  num renderTime;  
}