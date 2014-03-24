import 'dart:html';
import 'dart:math';
import 'dart:async';

// Set some dimensions for my animation
const int cW = 900;
const int cH = 550;
const fontSize = 11;

// Which letters we will be showing? "All I see is blonde, brunette, red-head".
const String letters = "01";

// Duration of the animation
const thirtyMills = const Duration(milliseconds:30);

var columns = cW/fontSize; //number of columns for the rain
var splittedLetters = letters.split('');
var drops = [];

CanvasElement canvas;
CanvasRenderingContext2D context;

void main() {
  // get access to the canvas
  canvas = querySelector('#canvasMatrix');
  context = canvas.getContext('2d');
  
  //create an array of drops column
  for(var i = 0; i < columns; i++){
    drops.add(1);
  }
  
  // Run drawCharacters every x milliseconds
  new Timer.periodic(thirtyMills, (Timer t) => drawCharacters());
}

void drawCharacters() {
  // apply colours and styles to the canvas context
  context.fillStyle = "rgba(0,0,0,0.05)";
  context.fillRect(0, 0, cW, cH);
  context.fillStyle = "#0f0"; //green text
  context.font = fontSize.toString() + "px arial";
  
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
}