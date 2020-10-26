package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;

using StringTools;

/**
 * Loosley based on FlxTypeText lolol
 */
class Alphabet extends FlxSpriteGroup
{
	public var delay:Float = 0.05;
	public var paused:Bool = false;

	var _finalText:String = "";
	var _curText:String = "";

	public var widthOfWords:Float = FlxG.width;

	var yMulti:Float = 1;

	// custom shit
	// amp, backslash, question mark, apostrophy, comma, angry faic, period
	var lastSprite:AlphaCharacter;
	var xPosResetted:Bool = false;

	public function new(x:Float, y:Float, text:String = "", ?bold:Bool = false)
	{
		super(x, y);

		_finalText = text;

		var arrayShit:Array<String> = text.split("");
		trace(arrayShit);

		var loopNum:Int = 0;

		new FlxTimer().start(0.05, function(tmr:FlxTimer)
		{
			var xPos:Float = 0;

			// trace(_finalText.fastCodeAt(loopNum) + " " + _finalText.charAt(loopNum));
			if (_finalText.fastCodeAt(loopNum) == "\n".code)
			{
				yMulti += 1;
				xPosResetted = true;
				// xPos = 0;
			}

			if (AlphaCharacter.alphabet.contains(arrayShit[loopNum].toLowerCase()))
			{
				if (lastSprite != null && !xPosResetted)
				{
					xPos = lastSprite.x + lastSprite.frameWidth - 40;
				}
				else
				{
					xPosResetted = false;
				}

				// trace(_finalText.fastCodeAt(loopNum) + " " + _finalText.charAt(loopNum));

				// var letter:AlphaCharacter = new AlphaCharacter(30 * loopNum, 0);
				var letter:AlphaCharacter = new AlphaCharacter(xPos, 55 * yMulti);
				letter.createBold(arrayShit[loopNum]);
				add(letter);

				lastSprite = letter;
			}

			loopNum += 1;

			tmr.time = FlxG.random.float(0.03, 0.09);
		}, arrayShit.length);

		for (character in arrayShit)
		{
			// if (character.fastCodeAt() == " ")
			// {
			// }

			if (AlphaCharacter.alphabet.contains(character.toLowerCase()))
			{
				/* var xPos:Float = 0;
					if (lastSprite != null)
					{
						xPos = lastSprite.x + lastSprite.frameWidth - 40;
					}

					// var letter:AlphaCharacter = new AlphaCharacter(30 * loopNum, 0);
					var letter:AlphaCharacter = new AlphaCharacter(xPos, 0);
					letter.createBold(character);
					add(letter);

					lastSprite = letter; */
			}

			// loopNum += 1;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}

class AlphaCharacter extends FlxSprite
{
	public static var alphabet:String = "abcdefghijklmnopqrstuvwxyz";

	var numbers:String = "1234567890";
	var symbols:String = "|~#$%()*+-:;<=>@[]^_";

	public function new(x:Float, y:Float)
	{
		super(x, y);
		var tex = FlxAtlasFrames.fromSparrow(AssetPaths.alphabet__png, AssetPaths.alphabet__xml);
		frames = tex;

		antialiasing = true;
	}

	public function createBold(letter:String)
	{
		animation.addByPrefix(letter, letter.toUpperCase() + " bold", 24);
		animation.play(letter);
		updateHitbox();
	}

	public function createLetter(letter:String):Void
	{
		var letterCase:String = "lowercase";
		if (letter.toLowerCase() != letter)
		{
			letterCase = 'capital';
		}

		animation.addByPrefix(letter, letter + " " + letterCase, 24);
		animation.play(letter);
	}
}
