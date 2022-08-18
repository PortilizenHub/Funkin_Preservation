package option_menus;

import Options.Gameplay;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class StreamerSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Text'];
	var textItemsBool:Array<Bool> = [];

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
			var optionText:FlxText = new FlxText(20, 20 + (i * 60), 0, '', 32);
			optionText.font = Paths.font('funker.otf');
			optionText.ID = i;
			grpOptionsTexts.add(optionText);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        textItemsBool = [];

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
			var text:String = 'coolswag';

			var enabledThing:Bool;
			enabledThing = textItemsBool[txt.ID];

			if (enabledThing)
				text = 'enabled';
			else if (!enabledThing)
				text = 'disabled';

            txt.text = textMenuItems[txt.ID] + ": " + text;

            txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{           
			}
		}
	}
}
