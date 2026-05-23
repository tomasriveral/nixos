{ ... }: {
  perSystem = { pkgs, ... }: {
  packages.custom-cowsay = pkgs.writeShellApplication {
    name = "custom-cowsay";
    runtimeInputs = with pkgs; [
      cowsay
    ];
    text = ''
  
      cows=("actually" "alpaca" "bud-frogs" "daemon" "elephant-in-snake" "moofasa" "skeleton" "three-eyes" "supermilker" "tux" "vader" "www")
      declare -a sentences=(
      "Sharing knowledge is the most fundamental act of friendship. Because it is a way you can give something without loosing something. -Richard Stallman"
      "Free software' is a matter of liberty, not price. To understand the concept, you should think of 'free' as in 'free speech,' not as in 'free beer'. -Richard Stallman"
      "Programming is not a science. Programming is a craft. -Richard Stallman"
      "I did write some code in Java once, but that was the island in Indonesia. -Richard Stallman"
      "Facebook is not your friend, it is a surveillance engine. -Richard Stallman"
      "People said I should accept the world. Bullshit! I don't accept the world. -Richard Stallman"
      "You can use any editor you want, but remember that vi vi vi is the text editor of the beast. -Richard Stallman"
      "The idea of copyright did not exist in ancient times, when authors frequently copied other authors at length in works of non-fiction. This practice was useful, and is the only way many authors' works have survived even in part. -Richard Stallman"
      "Idiots can be defeated but they never admit it. -Richard Stallman"
      "Open source is a development methodology; free software is a social movement. -Richard Stallman"
      "People sometimes ask me if it is a sin in the Church of Emacs to use vi. Using a free version of vi is not a sin; it is a penance. So happy hacking. -Richard Stallman"
      "A computer is like air conditioning - it becomes useless when you open Windows -Linus Torvald"
      "Intelligence is the ability to avoid doing work, yet getting the work done. -Linus Torvald"
      "Software is like sex: It's better when it's free. -Linus Torvald"
      "All operating systems sucks, but Linux just sucks less -Linus Torvald"
      "I like offending people, because I think people who get offended should be offended. -Linus Torval"
      "Talk is cheap. Show me the code. -Linus Torval"
      "Most of the good programmers do programming not because they expect to get paid or get adulation by the public, but because it is fun to program. -Linus Torvald"
      "Bad programmers worry about the code. Good programmers worry about data structures and their relationships. -Linus Torvald"
      "If Microsoft ever does applications for Linux it means I've won. -Linus Torvald"
      "Avoiding complexity reduces bugs. -Linus Torvald"
      "Backups are for wimps. Real men upload their data to an FTP site and have everyone else mirror it. -Linus Torvald"
      "Nobody actually creates perfect code the first time around, except me. But there's only one of me. -Linus Torvald"
      "Microsoft isn't evil, they just make really crappy operating systems. -Linus Torvald"
      "When you say 'I wrote a program that crashed Windows,' people just stare at you blankly and say 'Hey, I got those with the system, for free.' -Linus Torval"
      "C++ is a horrible language. It's made more horrible by the fact that a lot of substandard programmers use it, to the point where it's much much easier to generate total and utter crap with it. -Linus Torvald"
      "If you think your users are idiots, only idiots will use it. -Linus Torvald"
      "My name is Linus, and I am your God. -Linus Torvald"
      "An infinite number of monkeys typing into GNU emacs would never make a good program. -Linus Torvald"
      "Object-oriented programming is an exceptionally bad idea which could only have originated in California. -Edgser Dijkstra"
      "If debugging is the process of removing software bugs, then programming must be the process of putting them in. -Edgser Dijkstra"
      "The art of programming is the art of organizing complexity. -Edgser Dijkstra"
      "Program testing can be used to show the presence of bugs, but never to show their absence! -Edgser Dijkstra"
      "It is practically impossible to teach good programming to students that have had a prior exposure to BASIC: as potential programmers they are mentally mutilated beyond hope of regeneration. -Edgser Dijkstra"
      "The effort of using machines to mimic the human mind has always struck me as rather silly. I would rather use them to mimic something better. -Edgser Dijkstra"
      "Computer science is no more about computers than astronomy is about telescopes. -Edgser Dijkstra"
      "Programming in Basic causes brain damage. -Edgser Dijkstra"
      "The competent programmer is fully aware of the strictly limited size of his own skull; therefore he approaches the programming task in full humility, and among other things he avoids clever tricks like the plague. -Edgser Dijkstra"
      "If in physics there's something you don't understand, you can always hide behind the uncharted depths of nature. You can always blame God. You didn't make it so complex yourself. But if your program doesn't work, there is no one to hide behind. You cannot hide behind an obstinate nature. If it doesn't work, you've messed up. -Edgser Dijkstra"
      "Teaching COBOL ought to be regarded as a criminal act. -Edgser Dijkstra"
      "If you want more effective programmers, you will discover that they should not waste their time debugging, they should not introduce the bugs to start with. -Edgser Dijkstra"
      "If we wish to count lines of code, we should not regard them as 'lines produced' but as 'lines spent.' -Edgser Dijkstra"
      "In almost every computation a great variety of arrangements for the succession of the processes is possible, and various considerations must influence the selections amongst them for the purposes of a calculating engine. One essential object is to choose that arrangement which shall tend to reduce to a minimum the time necessary for completing the calculation. -Ada Lovelace"
      "I’m making an operating system myself, so I know what it’s like to be God. -Terry Davis"
      "I’m schizophrenic and so am I. -Terry Davis"
      "If I was a dog, I would bark. -Terry Davis"
      "Who has a better kernel? Debian? No. -Terry Davis"
      "Computers are fast, programmers keep it slow. -A random Reddit user"
      "Before software can be reusable it first has to be usable. -Ralph Johnson"
      "The best thing about a Boolean is that even if you are wrong, you're only off by a bit. -Anonymous"
      "It's not a bug, it's a feature. -Programmers"
      "NVIDIA, fuck you -Linus Torvald"
      )
      while true
      do
        echo
        echo
        echo
        echo
        echo
        echo
        SIndex=$(( RANDOM % ''${#sentences[@]} ))
        index=$(( RANDOM % ''${#cows[@]} ))
        #cow="/usr/share/cowsay/cows/''${cows[index]}.cow"
        cowsay -f "''${cows[index]}" "''${sentences[SIndex]}"
        sleep 10
        clear
      done
    '';
    # reduce terminal size for actually
  };
};}
