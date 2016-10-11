"Jewel Craft, Ivy Veil and the Amulet of Power" by Wesley Werner

[the amulet]
The Amulet is a thing. The description is "The amulet is seamless, like crafted from magic. There are four slots to hold four stones. You can [italic type]use amulet[roman type]."

Instead of taking the amulet:
	now the player carries the Amulet;
	say "The amulet feels solid and reassuring in your palms. 'What is this?'";
	say "Rain leans in, 'The Amulet of Power. It will help us defeat Burnspring, you need to find the four missing stones, and return in time to save us all, Ivy.'";
	say "You feel dread, but reassured by the magical token. 'How do I find these stones?'";
	say "'Go find the Riddler on the Hill, the amulet will guide you from there.', he sighs.";

Chapter I - Our story begins

When play begins, say "It is the Rising Epoch of Spells. A time of great discovery and powerful magic. But something terribly bad is about to happen."

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
	
