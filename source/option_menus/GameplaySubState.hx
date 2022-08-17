package option_menus;

import Options.Gameplay;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class GameplaySubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Mid Song Events', 'keybinds'];
	var textItemsBool:Array<Bool> = [Gameplay.midSongEvents, Gameplay.keybinds];

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
			var optionText:FlxText = new FlxText(20, 20 + (i * 50), 0, textMenuItems[i] + ": " + textItemsBool[i], 32);
			optionText.font = Paths.font('funker.otf');
			optionText.ID = i;
			grpOptionsTexts.add(optionText);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        textItemsBool = [Gameplay.midSongEvents, Gameplay.keybinds];

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
            if (textMenuItems[txt.ID] == 'keybinds' && textItemsBool[txt.ID] == true)
                txt.text = "keybinds: WASD";
            else if (textMenuItems[txt.ID] == 'keybinds' && textItemsBool[txt.ID] == false)
                txt.text = "keybinds: DFJK";

            txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{
				case "Mid Song Events":
                
                case "keybinds":
                    if (Gameplay.keybinds == true)
                        {
                            controls.setKeyboardScheme(None, 'dfjk', false);
                            Gameplay.keybinds = false;
                        }
                    else if (Gameplay.keybinds == false)
                        {
                            controls.setKeyboardScheme(None, 'wasd', false);
                            Gameplay.keybinds = true;
                        }
                    trace('keybinds');
                        
			}
		}
	}
}
