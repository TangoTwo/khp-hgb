#include <stdio.h>
#include "list_ads.h"

static void println(int value) {
    printf("%d\n", value);
}

int main() {
    printf("Test for List Project\n");
    init();
    prepend(35);
    prepend(17);
    prepend(42);
    print();

    forEach(println);
    destroy();
    return 0;
}