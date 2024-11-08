#include <stdio.h>
#include <string.h>

int general_version(char* entered_string) {
    int index = 0, count = 0;
    while (entered_string[index]) {
        if (entered_string[index] == 'E' || entered_string[index] == 'e'
            || entered_string[index] == 'Z' || entered_string[index] == 'z'){
            count++;
        }
        index++;
    }
    return count;
}

int simply_version(char* entered_string) {
    int index = 0;
    int count = 0;
while_start:
    if (!entered_string[index]) goto while_end;
    if (entered_string[index] == 'E') goto found;
    if (entered_string[index] == 'e') goto found;
    if (entered_string[index] == 'Z') goto found;
    if (entered_string[index] == 'z') goto found;
    goto increment;
found:
    count = count + 1;
increment:
    index = index + 1;
    goto while_start;
while_end:
    return count;
}


int main(){
    char entered_string[255];
    printf("Input the string which program will look for words containing symbols: \'Z\' or \'E\' in: ");
    scanf("%s", entered_string);

    printf("count of your name's and surname's first letters in general version: %d\n", general_version(entered_string));

    printf("count of your name's and surname's first letters in simply version: %d\n", simply_version(entered_string));

}
