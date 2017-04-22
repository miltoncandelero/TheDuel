package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import openfl.Lib;

class PlayState extends FlxState
{
	private var state: String = "ready";
	var now:Int;
	override public function create():Void
	{
		super.create();
		trace("ready");
		add(new FlxText(0,0,0,"EARLY PROTOTYPE. PLAY WITH DEBUG CONSOLE. PRESS F12. Shoot with X")); 
	}

	override public function update(elapsed:Float):Void
	{
		switch (state) 
		{
			case "ready":
				{
					if (FlxG.keys.justPressed.X){
						state = "set";
						trace("set");
						now = Lib.getTimer() + 1500;
					}
				}
			case "set":
				{
					trace("...");
					if (Lib.getTimer() >= now)
					{
						now = Lib.getTimer();
						state = "shoot";
						trace ("SHOOT!");
					}
					
				}
			case "shoot":
				{
					if (FlxG.keys.justPressed.X){
						state = "ready";
						trace ("BANG!");
						trace ((Lib.getTimer() - now) + "ms");
						trace ("again?");
					}
				}
				
			default:
				
		}
		super.update(elapsed);
	}
}