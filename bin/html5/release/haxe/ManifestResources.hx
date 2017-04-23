package;


import lime.app.Config;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Config):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "assetsPrefix")) {
			
			rootPath = Reflect.field (config, "assetsPrefix");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos)
			rootPath = "assets/";
			#elseif (windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash)
		openfl.text.Font.registerFont (__ASSET__OPENFL__font_5px_ttf);
		
		#end
		
		var data, manifest, library;
		
		data = '{"name":null,"assets":"aoy4:pathy12:img%2Fbg.pngy4:sizei8101y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y15:img%2Fenemy.pngR2i2014R3R4R5R7R6tgoR0y19:img%2Fenemyface.aseR2i3195R3y6:BINARYR5R8R6tgoR0y19:img%2Fenemyface.pngR2i1384R3R4R5R10R6tgoR0y16:img%2Ffacebg.pngR2i774R3R4R5R11R6tgoR0y16:img%2Fplayer.pngR2i1807R3R4R5R12R6tgoR0y20:img%2Fplayerface.pngR2i1375R3R4R5R13R6tgoR0y15:img%2Fready.pngR2i3559R3R4R5R14R6tgoR0y15:img%2Fshoot.pngR2i3497R3R4R5R15R6tgoR0y17:img%2FTextBox.pngR2i1343R3R4R5R16R6tgoR2i5233R3y5:MUSICR5y16:sound%2Fbang.mp3y9:pathGroupaR18y16:sound%2Fbang.oggy16:sound%2Fbang.wavhR6tgoR2i13152R3y5:SOUNDR5R20R19aR18R20R21hgoR2i24850R3R22R5R21R19aR18R20R21hgoR2i75844R3R17R5y16:sound%2Fbell.mp3R19aR23y16:sound%2Fbell.oggy16:sound%2Fbell.wavhR6tgoR2i122583R3R22R5R24R19aR23R24R25hgoR2i442110R3R22R5R25R19aR23R24R25hgoR2i332677R3R17R5y17:sound%2Fintro.mp3R19aR26y17:sound%2Fintro.oggy17:sound%2Fintro.wavhR6tgoR2i617126R3R22R5R27R19aR26R27R28hgoR2i2667452R3R22R5R28R19aR26R27R28hgoR2i35468R3y4:FONTy9:classNamey21:__ASSET__font_5px_ttfR5y14:font%2F5px.ttfR6tgh","version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__img_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }@:keep @:bind #if display private #end class __ASSET__img_enemy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }@:keep @:bind #if display private #end class __ASSET__img_enemyface_ase extends null { }
@:keep @:bind #if display private #end class __ASSET__img_enemyface_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }@:keep @:bind #if display private #end class __ASSET__img_facebg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }@:keep @:bind #if display private #end class __ASSET__img_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }@:keep @:bind #if display private #end class __ASSET__img_playerface_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }@:keep @:bind #if display private #end class __ASSET__img_ready_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }@:keep @:bind #if display private #end class __ASSET__img_shoot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }@:keep @:bind #if display private #end class __ASSET__img_textbox_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }@:keep @:bind #if display private #end class __ASSET__sound_bang_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__sound_bang_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__sound_bang_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__sound_bell_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__sound_bell_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__sound_bell_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__sound_intro_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__sound_intro_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__sound_intro_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__font_5px_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:image("assets/img/bg.png") #if display private #end class __ASSET__img_bg_png extends lime.graphics.Image {}
@:image("assets/img/enemy.png") #if display private #end class __ASSET__img_enemy_png extends lime.graphics.Image {}
@:file("assets/img/enemyface.ase") #if display private #end class __ASSET__img_enemyface_ase extends haxe.io.Bytes {}
@:image("assets/img/enemyface.png") #if display private #end class __ASSET__img_enemyface_png extends lime.graphics.Image {}
@:image("assets/img/facebg.png") #if display private #end class __ASSET__img_facebg_png extends lime.graphics.Image {}
@:image("assets/img/player.png") #if display private #end class __ASSET__img_player_png extends lime.graphics.Image {}
@:image("assets/img/playerface.png") #if display private #end class __ASSET__img_playerface_png extends lime.graphics.Image {}
@:image("assets/img/ready.png") #if display private #end class __ASSET__img_ready_png extends lime.graphics.Image {}
@:image("assets/img/shoot.png") #if display private #end class __ASSET__img_shoot_png extends lime.graphics.Image {}
@:image("assets/img/TextBox.png") #if display private #end class __ASSET__img_textbox_png extends lime.graphics.Image {}
@:file("assets/sound/bang.mp3") #if display private #end class __ASSET__sound_bang_mp3 extends haxe.io.Bytes {}
@:file("assets/sound/bang.ogg") #if display private #end class __ASSET__sound_bang_ogg extends haxe.io.Bytes {}
@:file("assets/sound/bang.wav") #if display private #end class __ASSET__sound_bang_wav extends haxe.io.Bytes {}
@:file("assets/sound/bell.mp3") #if display private #end class __ASSET__sound_bell_mp3 extends haxe.io.Bytes {}
@:file("assets/sound/bell.ogg") #if display private #end class __ASSET__sound_bell_ogg extends haxe.io.Bytes {}
@:file("assets/sound/bell.wav") #if display private #end class __ASSET__sound_bell_wav extends haxe.io.Bytes {}
@:file("assets/sound/intro.mp3") #if display private #end class __ASSET__sound_intro_mp3 extends haxe.io.Bytes {}
@:file("assets/sound/intro.ogg") #if display private #end class __ASSET__sound_intro_ogg extends haxe.io.Bytes {}
@:file("assets/sound/intro.wav") #if display private #end class __ASSET__sound_intro_wav extends haxe.io.Bytes {}
@:font("assets/font/5px.ttf") #if display private #end class __ASSET__font_5px_ttf extends lime.text.Font {}
@:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep #if display private #end class __ASSET__font_5px_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "font/5px"; #end name = "5squared pixel Regular"; super (); }}


#end

#if (openfl && !flash)

@:keep #if display private #end class __ASSET__OPENFL__font_5px_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__font_5px_ttf (); src = font.src; name = font.name; super (); }}


#end
#end