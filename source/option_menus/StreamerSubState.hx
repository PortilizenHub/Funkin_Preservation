package option_menus;

import Options.Streaming;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class StreamerSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['A-rated'];
	var textItemsBool:Array<Bool> = [Streaming.a_rated];

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

        textItemsBool = [Streaming.a_rated];

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
			txt.text = textMenuItems[txt.ID] + ": " + textItemsBool[txt.ID];
			
			if (textItemsBool[txt.ID] != null)
					trace('');
			else if (textItemsBool[txt.ID] == null)
					FlxG.log.error('item is null and does not have a value');

            txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{   
				case "A-rated":
					if (Streaming.a_rated == true)
						Streaming.a_rated = false;
					else if (Streaming.a_rated == false)        
						Streaming.a_rated = true;
			}
		}
	}
}
