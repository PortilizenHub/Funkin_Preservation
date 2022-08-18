package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionsSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Gameplay', 'Streaming'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<FlxText>;

	public function new()
	{
		super();

		grpOptionsTexts = new FlxTypedGroup<FlxText>();
		add(grpOptionsTexts);

		selector = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		// add(selector);

		for (i in 0...textMenuItems.length)
		{
			var optionText:FlxText = new FlxText(20, 20 + (i * 80), 0, textMenuItems[i], 32);
			optionText.font = Paths.font('funker.otf');
			optionText.ID = i;
			optionText.size = 64;
			grpOptionsTexts.add(optionText);
		}
		
		FlxG.state.closeSubState();
		FlxG.state.openSubState(new option_menus.GameplaySubState());
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UP_P)
			curSelected -= 1;

		if (controls.DOWN_P)
			curSelected += 1;

		if (controls.BACK)
			{
				FlxG.state.closeSubState();
				FlxG.switchState(new MainMenuState());
			}


		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		grpOptionsTexts.forEach(function(txt:FlxText)
		{
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{
				case "Gameplay":
					FlxG.state.closeSubState();
					FlxG.state.openSubState(new option_menus.GameplaySubState());

				case "Streaming":
					FlxG.state.closeSubState();
					FlxG.state.openSubState(new option_menus.StreamerSubState());

				default:
					FlxG.state.closeSubState();
					FlxG.state.openSubState(new option_menus.TemplateSubState());
			}
		}
	}
}
