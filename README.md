Config save
====================
A repo to save my config files, with a few perl scripts
to help synchronysing them with the rest of the system.
They also hide passwords and login in the config file
to make them publiable on the net.

To use it, you'll have to create 2 files :
 - cfglist : a text file with the absolute complete path
             to the files you want to save, one path per
             line.
 - tohide : a text file with the words you want to hide
            on your config files; on each line, you put
            the word you want to hide and its replacement.

Then run ./pull.pl to get all the files indicated on
cfglist on the local directory, with the words to hide
hidden. ./push.pl does the contrary : it unhide the words
and dispatch the files to their original location.

