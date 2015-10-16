# distsys

- make sure that the cmsg file is empty
- open a terminal and ssh to one of nodes listed in the ukkonodes file
- run mouse.sh
- open another tab and ssh to a node not listed in the ukkonodes file
- make sure that all included files reside in the current directory
- insert the address of current node to the listy_location file
- run cordy.sh

Now Cordy will take charge of the hunt and will go through listed nodes until the mouse is found. After Cordy receives a word of a successfull attack, he will print out MOUSE DESTROYED and end excecution.
