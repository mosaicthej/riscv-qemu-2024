#include <stdio.h>

int inputNumber() {
  int num;
  printf("Enter a number: ");
  scanf("%d", &num);
  return num;
}
/*
int addTen(int num) {
  return num + 10;
}
*/
void printNumber(int num) {
  printf("Number plus 10 is %d\n", num);
}

int main() {
  int num = inputNumber();
  num = addTen(num);
  printNumber(num);
  return 0;
}

