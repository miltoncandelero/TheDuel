package;

import flash.display.Shape;
import flixel.system.FlxBasePreloader;
import openfl.Lib;
import openfl.display.Preloader;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.ProgressEvent;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.text.Font;

// <assets path="assets/preloader" include="*" if="web" />



//@:font("assets/fonts/HelveticaRoundedLTBlack.ttf") class DefaultFont extends Font {}
@:bitmap("assets/preloader/logo.png") class Splash extends BitmapData { }


/**
 * ...
 * @author Killabunnies
 */
class CustomPreloader extends FlxBasePreloader
{
	private var LOGO_WIDTH:Int = 180;
	private var LOGO_HEIGHT:Int = 220;
	
	static var color = 0xFF00FF; //the main color
	static var backgroundColor = 0x333333; //background color

	var originalBackgroundColor:Int;
	var rectangle:Sprite;

	public var splash:Bitmap;
	public var lastTime:Int;

	public override function create () {
		
		super.create();
		init ();
	}
	
	

	private function init ():Void {

		
		stage.color = backgroundColor;

		rectangle = new Sprite();
		
		
        splash = (new Bitmap(new Splash(0,0))); //Sets the graphic of the sprite to a Bitmap object, which uses our embedded BitmapData class.
		
		addChild(rectangle);
		
		
		addChild(splash); //add the logo
		
		splash.x = (stage.stageWidth - LOGO_WIDTH) / 2;
		splash.y = (stage.stageHeight - LOGO_HEIGHT) / 2;
		
    }	
	
	override function update(Percent:Float):Void
	{
		var percentLoaded = Percent;
		
		if (percentLoaded > 1) percentLoaded = 1;
		
		rectangle.graphics.clear();
		rectangle.graphics.beginFill(color);
		rectangle.graphics.drawRect(0, 0, percentLoaded*512, 50);
		rectangle.graphics.endFill();
	}



	override public function onLoaded()
	{
		super.onLoaded();
		_loaded = false;
	}

	
}