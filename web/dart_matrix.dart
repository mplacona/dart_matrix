import 'dart:html';
import 'dart:math';

class MatrixEffect{
  // Set some dimensions for my animation
  static const int cW = 900;
  static const int cH = 550;
  static const fontSize = 11;
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  var drops = [];
  // Which letters we will be showing? "All I see is blonde, brunette, red-head".
  static const String letters = "01";
  var columns = cW/fontSize; //number of columns for the rain
  var splittedLetters = letters.split('');
  
  MatrixEffect(CanvasElement _canvas, CanvasRenderingContext2D _context){
    canvas = _canvas;
    context = _context;
    
    //create an array of drops column
    for(var i = 0; i < columns; i++){
      drops.add(1);
    }
  }
  
  void requestRedraw() {
    window.requestAnimationFrame(drawCharacters);
  }

  void drawCharacters(num _) { 
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
    this.requestRedraw();
  }
}

void main() {
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  
  // get access to the canvas
  canvas = querySelector('#canvasMatrix');
  context = canvas.getContext('2d');
  
  MatrixEffect matrixEffect = new MatrixEffect(canvas, context);
  
  // Run drawCharacters every x milliseconds
  matrixEffect.requestRedraw();
}