package;

import openfl.display.Sprite;
import openfl.Lib;

/**
 * ...
 * @author eCode
 */
class Main extends Sprite 
{
	var game:Game;

	public function new() 
	{
		super();
		PlayGame();
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
	}
	
	public function PlayGame()
	{
		removeChild(game);
		game = null;
		game = new Game();
		addChild(game);
	}

}
