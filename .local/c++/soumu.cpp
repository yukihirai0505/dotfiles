#include  <stdlib.h>

int main() {

  char cmd[] = "rm -Rf $HOME/Downloads/* $HOME/Desktop/* $HOME/.Trash/ && mkdir $HOME/.Trash";
  system(cmd);  

  return 0;
}

