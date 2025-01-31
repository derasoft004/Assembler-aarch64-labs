#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


void access_easy(int a, int b, int c, int d) {
    int combined = (a | (b << 16));
    int result = combined - d;
    
    bool condition = result < 0;
    if (condition) {
        printf("Access granted\n");
    } else {
        printf("Access denyed\n");
    }
    return ;
}


struct List{
    int value;
    short flag;
} ;

struct DataCompare{
    float threshold;
} ;


void access_hard(struct List *list, struct DataCompare *data) {
    int calculated_value = (list->value << list->flag) + (list->value >> 2);
    float comparison_value = (float)calculated_value;

    bool condition = comparison_value > data->threshold;
    if (condition) {
        printf("Access granted\n");
        return ;
    } else {
        printf("Access denyed\n");
        return ;
    }
};


int main() {
    printf("Easy lvl\n");
    
    int a = 0;
    int b = 0;
    int c = 0;
    int d = 1;

    access_easy(a, b, c, d);
    
    
    printf("Hard lvl\n");
    struct List list1 = {50, 3};
    struct DataCompare data_compare = {75.0};

    access_hard(&list1, &data_compare);

    return 0;
}
