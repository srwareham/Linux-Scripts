/* 
 Written by Sean Wareham on February 17, 2014

 Simple program to quickly use apt-get update and upgrade without needing a password.

I am partial to the use of "update" but I will reference it as compiled_binary_name
(Note, you should not use quotes in your name and it should contain no spaces)

 Compile with:
 gcc update.c -o compiled_binary_name
 After this script is compiled run:
 sudo chown root:root compiled_binary_name
 sudo chmod 4755 compiled_binary_name

 (Optional to add binary to PATH so that it can be run from anywhere)
 sudo mv compiled_binary_name /usr/local/bin/

 Now simply type compiled_binary_name in your terminal and it will run without requesting a password.
 This is done through use of the setuid unix functionality that is commonly hampered in linux distros
 due to the potential security risks involved. Do be mindful of what you do with root.
*/
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
    setuid(0);
    system("sudo apt-get update");
    system("sudo apt-get upgrade");
    system("sudo apt-get autoclean");
    return 0;
}
