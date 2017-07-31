# Personal scripts

Some scripts i made to make my life easier. They go into /usr/bin (or anywhere else in your PATH)

## tblscrot

Takes a screenshot (using either `gnome-screenshot`, `spectacle` or `scrot`), copies it to `~/Pictures/Screenshots`,
uploads it to a server using `scp` and copies a link to the clipboard. Basically a home-mande alternative to ShareX.

It's designed to be assigned to a global keyboard shortcut, so it makes use of libnotify notifications and attempts
not to depend on a terminal.

### Requirements

 - OpenSSH and Python
 - pyperclip and notify2 (`pip install pyperclip notify2`)
 - Either gnome-screenshot, spectacle or scrot to take the screenshots (check the script)
 - Having copied your SSH key to the destination server, to avoid the login prompt
   - You can also specify `server = "username:'pasword'@host:/path/"` at the begginning of the script but that's basically
   storing your password in plain text and it's not recommended.

Edit the script to change the destination server and URL to copy to clipboard
