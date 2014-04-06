import 'dart:html';
import 'dart:math';

// Set some dimensions for my animation
const int cW = 900;
const int cH = 550;
const fontSize = 11;

// Which letters we will be showing? "All I see is blonde, brunette, red-head".
const String letters = "01";

var columns = cW/fontSize; //number of columns for the rain
var splittedLetters = letters.split('');
var drops = [];

CanvasElement canvas;
CanvasRenderingContext2D context;

/// Display the animation's FPS in a div.
Element notes = querySelector("#fps");
num fpsAverage;
num renderTime;

void showFps(num fps) {
  if (fpsAverage == null) fpsAverage = fps;
  fpsAverage = fps * 0.05 + fpsAverage * 0.95;
  notes.text = "${fpsAverage.round()} fps";
}

void main() {
  // get access to the canvas
  canvas = querySelector('#canvasMatrix');
  context = canvas.getContext('2d');
  
  //create an array of drops column
  for(var i = 0; i < columns; i++){
    drops.add(1);
  }
  
  // Run drawCharacters every x milliseconds
  requestRedraw();
}

void requestRedraw() {
  window.requestAnimationFrame(drawCharacters);
}

void drawCharacters(num _) {
  // fps
  num time = new DateTime.now().millisecondsSinceEpoch;
  if (renderTime != null) showFps(1000 / (time - renderTime));
  renderTime = time;
  
  // apply colours and styles to the canvas context
  context
    ..fillStyle = "rgba(0,0,0,0.05)"
    ..fillRect(0, 0, cW, cH)
    ..fillStyle = "#0f0" //green text
    ..font = fontSize.toString() + "px arial";
  
  var rng = new Random(); // apply some randomness
  
  //loop over each of the drops
  for(var i = 0; i < drops.length; i++)
  {
    var text = splittedLetters[rng.nextInt(splittedLetters.length)];
    context.fillText(text, i*fontSize, drops[i]*fontSize);
    
    // send the single drop back to the top once it's gone through the screen
    if(drops[i]*fontSize > cH && rng.nextDouble() > 0.975){
      drops[i] = 0;
    }
    
    //incrementing Y coordinate so our drops move
    drops[i]++;
  }
  requestRedraw();
}