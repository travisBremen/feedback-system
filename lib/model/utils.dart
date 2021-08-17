import 'conversationText.dart';

List<ConversationText> createText() {
  List<ConversationText> textList = [];
  for (int i = 1; i <= 10; i++) {
    String string1 = '';
    String string2 = '';
    String string3 = 'null';

    switch (i) {
      case 1:
        string1 =
            'Adam: Do you know what is the longest word in the English language?';
        string2 = 'Bella: Um… I have no idea.';
        string3 =
            'Adam: “Smiles”. Because there is a mile between its first and last letters!';
        break;
      case 2:
        string1 =
            'Me: Thanks for having me at your party yesterday. I had a great time!';
        string2 = 'Angela: No problem. We should hang out more.';
        break;
      case 7:
        string1 =
            'Ben: Did you watch the football match between Germany and England last night?';
        string2 = 'Chris: I wish I hadn\'t...';
        break;
      case 4:
        string1 =
            'Blake: Sorry to tell you this, but the party this weekend has to be canceled because of COVID.!';
        string2 = 'Chloe: Oh, that’s too bad.';
        break;
      case 10:
        string1 =
            'Charlie: Hey guys, have you heard that Jack’s just split up with her girlfriend?';
        string2 =
            'Daisy: I can’t believe it. They’ve been together for so many years.';
        break;
      case 5:
        string1 =
            'Cameron: We made a little mistake. The deadline for the final assignment is this Sunday not next!';
        string2 = 'Daniel: Oh, come on.';
        break;
      case 3:
        string1 =
            'David: I’m thinking of making the interface of our system into a tangible one.';
        string2 = 'Eva: Well, we can have a try. Any other ideas?';
        break;
      case 6:
        string1 =
            'Dylan: What do you think of our trip to South Germany that last time we talked about?';
        string2 =
            'Emma: I am still thinking about it. Which cities shall we go to?';
        break;
      case 9:
        string1 = 'Ethan: You know what? I just passed the exam with a 1.0!';
        string2 = 'Friede: Wow, congrats!';
        break;
      case 8:
        string1 =
            'Emily: The lockdown for COVID is finally lifted. We can go to the popular restaurant I mentioned this weekend.';
        string2 = 'Fred: It’s so exciting to see each other again.';
        break;
    }
    textList.add(ConversationText(string1, string2, string3));
  }
  return textList;
}
