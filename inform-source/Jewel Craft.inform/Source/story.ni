"Jewel Craft, Ivy Veil and the Amulet of Power" by Wesley Werner

Section 1 - Testing Helpers - Not for release

Adding a stone is an action out of world. Understand "give a stone" as adding a stone.
Carry out adding a stone:
	if the level of the amulet is less than 3:
		Increase the level of the amulet by 1;
		say "You got a new stone (debug).";

Section 2 - The amulet definition

[the amulet]
The Amulet is a thing. The description is "[if level of amulet is 0]There are four empty slots to hold four stones[end if][if level of amulet is greater than 0]You have the Amethyst stone[end if][if level of amulet is greater than 1], the Emerald stone[end if][if level of amulet is greater than 2], the Obsidian stone[end if][if level of amulet is greater than 3] and the Amber stone[end if].[line break][italic type][if level of amulet is greater than 0]You can use the amulet for [end if][if level of amulet is greater than 0]Protection[end if][if level of amulet is greater than 1], Insight[end if][if level of amulet is greater than 2], Strength[end if][if level of amulet is greater than 3] or Healing[end if][roman type]".
Ability is a kind of value. The abilities are none, protection, insight, strength and healing.
The amulet has an ability. The ability of the amulet is none.
The amulet has a number called level. The amulet has level 0.
The amulet has a number called time left. The time left of the amulet is 0.

[assist the player]
Understand "use amulet" as a mistake ("You can use amulet for protection/insight/strength/healing").

[constants used by the amulet abilities]
The ability timeout is always 20.
The ability warning is always 5.

[amulet protection ability]
Activating protection is an action applying to nothing. Understand "use amulet for protection" or "use the amulet for protection" as Activating protection.

Check activating protection:
	if the level of amulet is less than 1:
		say "Your amulet does not have the stone for that ability.";
		stop the action;
	if the ability of the amulet is protection:
		say "That ability is already activated.";
		stop the action;

Carry out activating protection:
	if the ability of the amulet is not none:
		say "Your ability of [ability of amulet] is now removed.";
	now the ability of the amulet is protection;
	now the time left of the amulet is the ability timeout;

Report activating protection:
	say "You feel protected from evil curses.";

[amulet insight ability]
Activating insight is an action applying to nothing. Understand "use amulet for insight" or "use the amulet for insight" as Activating insight.

Check activating insight:
	if the level of amulet is less than 2:
		say "Your amulet does not have the stone for that ability.";
		stop the action;
	if the ability of the amulet is insight:
		say "That ability is already activated.";
		stop the action;

Carry out activating insight:
	if the ability of the amulet is not none:
		say "Your ability of [ability of amulet] is now removed.";
	now the ability of the amulet is insight;
	now the time left of the amulet is the ability timeout;

Report activating insight:
	say "Your intuition heightens.";

[amulet strength ability]
Activating strength is an action applying to nothing. Understand "use amulet for strength" or "use the amulet for strength" as Activating strength.

Check activating strength:
	if the level of amulet is less than 3:
		say "Your amulet does not have the stone for that ability.";
		stop the action;
	if the ability of the amulet is strength:
		say "That ability is already activated.";
		stop the action;

Carry out activating strength:
	if the ability of the amulet is not none:
		say "Your ability of [ability of amulet] is now removed.";
	now the ability of the amulet is strength;
	now the time left of the amulet is the ability timeout;

Report activating strength:
	say "You feel strength coursing through your body.";

[amulet healing ability]
Activating healing is an action applying to nothing. Understand "use amulet for healing" or "use the amulet for healing" as Activating healing.

Check activating healing:
	if the level of amulet is less than 4:
		say "Your amulet does not have the stone for that ability.";
		stop the action;
	if the ability of the amulet is healing:
		say "That ability is already activated.";
		stop the action;

Carry out activating healing:
	if the ability of the amulet is not none:
		say "Your ability of [ability of amulet] is now removed.";
	now the ability of the amulet is healing;
	now the time left of the amulet is the ability timeout;

Report activating healing:
	say "You are enveloped by a healing aura.";

[amulet ability decay]
Every turn when the time left of the amulet is greater than 0:
	decrease the time left of the amulet by 1;
	if the time left of the amulet is the ability warning:
		say "You feel your [ability of the amulet] fading.";
	if the time left of the amulet is 0:
		say "Your [ability of the amulet] has worn off.";
		now the ability of the amulet is none;

Instead of taking the amulet:
	now the player carries the Amulet;
	say "The amulet is seamless, like crafted from magic, it feels solid and reassuring in your palms. 'What is this?'";
	say "Rain leans in, 'The Amulet of Power. It will help us defeat Burnspring, you need to find the four missing stones, and return in time to save us all, Ivy.'";
	say "You feel dread, but reassured by the magical token. 'How do I find these stones?'";
	say "'Go find the Riddler on the Hill, the amulet will guide you from there.', he sighs.";

Chapter I - Our story begins

When play begins:
	say "It is the Rising Epoch of Spells. A time of great discovery and powerful magic. But something terribly bad is about to happen.";

Your Home is a room. "A cosy place."
The player is in Your Home.
The Amulet is in Your Home.
The hearth is scenery in Your Home. The description is "The dying embers are covered in ash."
The table is scenery in Your Home.  The description is "An old sturdy wooden table where you work on your jewels. There are various tools and items on the table, none of them are needed right now."

Carry out looking in Home for the first time:
	say "Your friend Rain Arcana bursts through your door: 'Ivy! We need your help!'";
	say "'What is going on, Rain?'";
	say "'Burnspring the Sorcerous trapped the magician's guild in a powerful spell, the city is powerless against him!' he pants.";
	say "'My help? I make jewelry, how in the name of Anerat can I help?', you feel uneasy.";
	say "Rain steadies himself, 'Our magicians are trapped, to be sure, and I fear I will be taken soon.'";
	say "Rain holds out an amulet for you to take.";

[NOTES
Test if the player has been here before with [if unvisited]. A room is considered to be "unvisited" until after the player has seen its description for the first time.

A more verbose alternative, and demonstrating we can even test if another room has been visited: [if the Hill Path is unvisited].

We can also use [if the player is in the Hill Path for the first time] but this will only adapt the text after the player leaves and re-enters the room.
]
The Hill Path is a room. "[if the Hill Path is unvisited]There is shrubbery and trees around you. You can hear water flowing, but cannot see much through the dense foliage. [end if]Town is due south, you have no need to go back there right now."

A wooden door is a door. The description is "A sturdy wooden door that leads outside." It is outside from Your Home. Through it is the Hill Path. [a one-sided door only leading out]
Instead of opening a wooden door when the player is not carrying the Amulet:
	say "Best you take the amulet with you."
	
