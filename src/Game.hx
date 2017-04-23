package;

import motion.Actuate;
import motion.easing.Linear;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.BlendMode;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.media.Sound;
import openfl.net.SharedObject;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.ui.Keyboard;
import openfl.utils.Assets;
import spritesheet.AnimatedSprite;
import spritesheet.Spritesheet;
import spritesheet.data.BehaviorData;
import spritesheet.importers.BitmapImporter;

/**
 * ...
 * @author eCode
 */
class Game extends Sprite 
{
	private var AnyKey:Bool = false;
	
	var state:String = "waiting";
	
	var now:Int;
	var keys:Array<Bool>;
	var frames:Int;
	var Background:Bitmap;
	var PlayerSheet:Spritesheet;
	var Player:AnimatedSprite;
	
	var EnemySheet:Spritesheet;
	var Enemy:AnimatedSprite;
	
	var PlayerFace:Bitmap;
	var EnemyFace:Bitmap;
	var PlayerBG:Sprite;
	var EnemyBG:Sprite;
	
	var Clock:Bitmap;
	
	var bmdReady:BitmapData;
	var bmdShoot:BitmapData;
	
	
	var WinBoard:Sprite;
	
	//DT
	var currentTime:Int;
	var dt:Int;
	var previousTime:Int;
	var sharedObject:SharedObject;
	
	var timetobeat:Int = 900;
	var textField:TextField;
	var format:TextFormat;
	var Container:Sprite;
	
	public function new() 
	{
		super();
	
		sharedObject = SharedObject.getLocal("LD38THEDUEL", "/");
		if (sharedObject.data.record == null) {
			timetobeat = 900;
			sharedObject.data.record = timetobeat;
			sharedObject.flush();
		}else 
		{
			timetobeat = sharedObject.data.record;
		}
		
		Container = new Sprite();
		Container.y = 216;
		
		WinBoard = new Sprite();
		WinBoard.graphics.beginBitmapFill(Assets.getBitmapData("img/TextBox.png"));
		WinBoard.graphics.drawRect(0, 0, 512, 72);
		WinBoard.graphics.endFill();
		WinBoard.alpha = 0.75;
		Container.addChild(WinBoard);
		//Texts
		textField = new TextField();
		format = new TextFormat(Assets.getFont("font/5px.ttf").fontName, 18, 0xffFFFF);
		format.align = TextFormatAlign.CENTER;
		textField.defaultTextFormat = format;
		textField.text = "You got killed by your opponent in 999ms";
		textField.embedFonts = true;
		textField.mouseEnabled = false;
		textField.selectable = false;
		textField.textColor = 0xffFFFF;
		textField.width = 512;
		
		textField.x = 0;
		textField.y = 0;
		Container.addChild(textField);

		
		
		

		Background = new Bitmap(Assets.getBitmapData("img/bg.png"));
		addChild(Background);
		
		PlayerSheet = BitmapImporter.create(Assets.getBitmapData("img/player.png"), 4, 4, 16, 24);
		PlayerSheet.addBehavior(new BehaviorData("walk", [0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3], true, 5));
		PlayerSheet.addBehavior(new BehaviorData("stand", [3], false));
		PlayerSheet.addBehavior(new BehaviorData("shoot", [7], false));
		PlayerSheet.addBehavior(new BehaviorData("dead", [15], false));
		
		Player = new AnimatedSprite(PlayerSheet);
		Player.x = -16;
		Player.y = 160;
		
		Player.showBehavior("walk");
		
		addChild(Player);
		
		EnemySheet = BitmapImporter.create(Assets.getBitmapData("img/enemy.png"), 4, 4, 16, 24);
		EnemySheet.addBehavior(new BehaviorData("walk", [0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3], true, 5));
		EnemySheet.addBehavior(new BehaviorData("stand", [0], false));
		EnemySheet.addBehavior(new BehaviorData("shoot", [4], false));
		EnemySheet.addBehavior(new BehaviorData("dead", [15], false));
		
		Enemy = new AnimatedSprite(EnemySheet);
		Enemy.x = 512+16;
		Enemy.y = 160;
		
		Enemy.showBehavior("walk");
		
		addChild(Enemy);
		
		addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		addEventListener(Event.ADDED_TO_STAGE, loaded, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, removed, false, 0, true);
		keys = [];
		
		PlayerFace = new Bitmap(Assets.getBitmapData("img/playerface.png"));
		PlayerFace.x = -512;
		
		EnemyFace = new Bitmap(Assets.getBitmapData("img/enemyface.png"));
		EnemyFace.x = 512;
		EnemyFace.y = 144;
		
		PlayerBG = new Sprite();
		EnemyBG = new Sprite();
		
		PlayerBG.graphics.beginBitmapFill(Assets.getBitmapData("img/facebg.png"));
		PlayerBG.graphics.drawRect(0, 0, 1024, 144);
		PlayerBG.graphics.endFill();
		
		EnemyBG.graphics.beginBitmapFill(Assets.getBitmapData("img/facebg.png"));
		EnemyBG.graphics.drawRect(0, 144, 1024, 144);
		EnemyBG.graphics.endFill();
		
		PlayerBG.x = -1024;
		EnemyBG.x = 512;
		
		bmdReady = Assets.getBitmapData("img/ready.png");
		bmdShoot = Assets.getBitmapData("img/shoot.png");
		
		Clock = new Bitmap(bmdReady);
		
		Clock.x = 128;
		Clock.y = 288;
		
		Container.visible = false;
		addChild(Container);

		addChild(PlayerBG);
		addChild(EnemyBG);
		addChild(PlayerFace);
		addChild(EnemyFace);
		
		addChild(Clock);
		
	}
	
	private function removed(e:Event):Void 
	{
		stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		removeEventListener(Event.ENTER_FRAME, update);
		removeEventListener(Event.REMOVED_FROM_STAGE, removed);
	}
	
	private function loaded(e:Event):Void 
	{
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp, false, 0, true);
		
		var intro:Sound = Assets.getSound("sound/intro.ogg");
		intro.play();
		
		Actuate.tween(Player, 6, {x : 150}).ease(Linear.easeNone).onComplete(stand);
		Actuate.tween(Enemy, 6, {x : 512-150-16}).ease(Linear.easeNone).onComplete(stand);
		
		removeEventListener(Event.ADDED_TO_STAGE, loaded);
	}
	
	function stand() 
	{
		Player.showBehavior("stand");
		Enemy.showBehavior("stand");
		
		Actuate.tween(PlayerBG, 0.5, {x: -512}).ease(Linear.easeNone).onComplete(startLoop);
		Actuate.tween(EnemyBG, 0.5, {x:0}).ease(Linear.easeNone);
		
		Actuate.tween(PlayerFace, 0.5, {x:0}).ease(Linear.easeNone);
		Actuate.tween(EnemyFace, 0.5, {x:0}).ease(Linear.easeNone);
	}
	
	function startLoop() 
	{
		Actuate.tween(PlayerBG, 0.5, {x: 0}).ease(Linear.easeNone).repeat();
		Actuate.tween(EnemyBG, 0.5, {x: -512}).ease(Linear.easeNone).repeat();
		Actuate.tween(Clock, 2, {y: (288 - 384) }).delay(2).onComplete(startgame);
	}
	
	function startgame() 
	{
		Container.visible = true;
		now = Lib.getTimer() + 4000 + Math.floor(Math.random() * 1000);
		state = "set";
	}
	
	var CheatFlag:Bool = false;
	private function update(e:Event):Void 
	{
		currentTime = Lib.getTimer ();
		dt = (currentTime - previousTime);
		previousTime = currentTime;
		
		Player.update(dt);
		Enemy.update(dt);
		switch (state) 
		{
			case "set":
				{
					if (keys[Keyboard.X] && !CheatFlag){
						CheatFlag = true;
						var sound2:Sound = Assets.getSound("sound/bang.ogg");
						sound2.play();
						var shoottime:Int = Lib.getTimer() - now;
						
						textField.text = "YOU CHEATED by "+ Math.abs(shoottime) +"ms. Shame on you";
						
						Enemy.showBehavior("dead");
						Player.showBehavior("shoot");
						
					}
					
					if (Lib.getTimer() >= now)
					{
						now = Lib.getTimer();
						var sound:Sound = Assets.getSound("sound/bell.ogg");
						Clock.bitmapData = bmdShoot;
						sound.play();
						frames = 0;
						if (CheatFlag){ EndGame(); state = "cheat";} else state = "shoot";
					}
					
				}
			case "shoot":
				{
					frames++;
					
					if ((Lib.getTimer() - now) > timetobeat){
							textField.text = "You got killed by your opponent in " + (Lib.getTimer() - now) +"ms";
							
							Player.showBehavior("dead");
							Enemy.showBehavior("shoot");
							
							state = "endgame";
							
							var sound2:Sound = Assets.getSound("sound/bang.ogg");
							sound2.play();
							EndGame();
							return;
						}
						
					if (keys[Keyboard.X]){
						state = "endgame";
						var sound2:Sound = Assets.getSound("sound/bang.ogg");
						sound2.play();
						var shoottime:Int = Lib.getTimer() - now;
						
						textField.text = "You killed your opponent in "+ shoottime +"ms";
						
						Enemy.showBehavior("dead");
						Player.showBehavior("shoot");
						
						sharedObject.data.record = shoottime;
						
						sharedObject.flush();
						
						EndGame();
					}
				}
				
			case "readyToReset":
				{
					if (keys[Keyboard.X]) 
					{
						cast(parent, Main).PlayGame();
					}
					if (keys[Keyboard.R]) 
					{
						textField.text = "Records deleted. Press X to play again.";
						sharedObject.data.record = 900;
						sharedObject.flush();					
					}
				}
			default:
		}
		
	}
	
	function EndGame() 
	{
		Actuate.tween(Clock, 0.5, {y : 512});
		Actuate.tween(PlayerFace, 0.5, {y: -144}).ease(Linear.easeNone);
		Actuate.tween(PlayerBG, 0.5, {y: -144}).ease(Linear.easeNone);
		
		Actuate.tween(EnemyFace, 0.5, {y: 288}).ease(Linear.easeNone);
		Actuate.tween(EnemyBG, 0.5, {y: 288}).ease(Linear.easeNone);
		Actuate.timer(2).onComplete(ReadyToReset);
	}
	
	function ReadyToReset() 
	{
		textField.text = textField.text + "\n(Press X to play again)\n(Press R to delete the record of: " + sharedObject.data.record + "ms)";
		state = "readyToReset";
	}
	
	private function onKeyDown(evt:KeyboardEvent):Void {
		keys[evt.keyCode] = true;
	}

	private function onKeyUp(evt:KeyboardEvent):Void {
		keys[evt.keyCode] = false;
	}
}