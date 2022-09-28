package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import openfl.Lib;
import lime.tools.WindowData;
import openfl.filters.BitmapFilter;
import lime.graphics.Image;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.2'; //This is also used for Discord RPC

	var bluebg:FlxSprite;
	var gauntletOption:FlxSprite;
	var freeplayOption:FlxSprite;
	var creditsOption:FlxSprite;
	var optionsOption:FlxSprite;

	var debugKeys:Array<FlxKey>;

	override function create()
	{
		Lib.application.window.title = "HAPPY BIRTHDAY PUNMASTER";
		Lib.application.window.setIcon(Image.fromBitmapData(Paths.image("appicons/punmaster").bitmap));

		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		FlxG.mouse.visible = true;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));


		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		bluebg = new FlxSprite();
		bluebg.makeGraphic(FlxG.width, FlxG.height, 0xFF00EEFF, true);
		bluebg.screenCenter(X);
		bluebg.screenCenter(Y);
		bluebg.scale.set(1.20, 1.20);
		add(bluebg);

		gauntletOption = new FlxSprite(50, 50);
		gauntletOption.loadGraphic(Paths.image('punmenuassets/gauntlet'));
		gauntletOption.scale.set(1, 1);
		add(gauntletOption);

		freeplayOption = new FlxSprite(725, 50);
		if(!ClientPrefs.freeplayUnlocked) {
			freeplayOption.loadGraphic(Paths.image('punmenuassets/freeplayLocked'));
		}else{
			freeplayOption.loadGraphic(Paths.image('punmenuassets/freeplay'));
		}
		freeplayOption.scale.set(1, 1);
		add(freeplayOption);

		creditsOption = new FlxSprite(400, 400);
		creditsOption.loadGraphic(Paths.image('punmenuassets/credits'));
		creditsOption.scale.set(1, 1);
		add(creditsOption);

		optionsOption = new FlxSprite(650, 400);
		optionsOption.loadGraphic(Paths.image('punmenuassets/options'));
		optionsOption.scale.set(1, 1);
		add(optionsOption);

		super.create();
	}


	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (!selectedSomethin)
		{
			//i hate myself
			if(FlxG.mouse.justPressed && FlxG.mouse.overlaps(gauntletOption))
			{
				FlxG.mouse.visible = false;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxG.sound.music.stop();
				FlxFlicker.flicker(gauntletOption, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
					MusicBeatState.switchState(new StoryMenuState());
					FreeplayState.destroyFreeplayVocals();
				});
			}

			//freeplay: shid (pinmister)

			else if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(freeplayOption) && ClientPrefs.freeplayUnlocked)
			{
				FlxG.mouse.visible = false;
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxFlicker.flicker(freeplayOption, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
					MusicBeatState.switchState(new FreeplayState());
				});
			}
			else if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(freeplayOption) && !ClientPrefs.freeplayUnlocked)
			{
				FlxG.sound.play(Paths.sound('buzzer'), 0.7);
				FlxG.camera.shake(0.05, 0.5);
			}
			else if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(creditsOption))
			{
				FlxG.mouse.visible = false;
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxFlicker.flicker(creditsOption, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
					MusicBeatState.switchState(new CreditsState());
				});
			}
			else if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(optionsOption))
			{
				FlxG.mouse.visible = false;
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxFlicker.flicker(optionsOption, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
					LoadingState.loadAndSwitchState(new options.OptionsState());
				});
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				FlxG.mouse.visible = false;
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

	}
}
