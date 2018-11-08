#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NAME_LEN 30

typedef struct person {
	char name[MAX_NAME_LEN];
	int age;
	char gender; // 'M', 'F'	
} person;

int main() {
	person p1;
	p1.age = 21;
	p1.gender = 'M';
	strcpy(p1.name, "Hiesel");

	person p2 = {"Hiesel", 21, 'M'};
	printf("p2.name=%s\n", p2.name);
	printf("add(p2.name)=%p\n", (void*)(p2.name));
	printf("p2.name[0]=%c\n", *(p2.name));
	printf("sizeof(person)=%d\n", (int)sizeof(person));

	person *pers_ptr = malloc(sizeof(person));
	if(pers_ptr == NULL) {
		printf("Out of memory");
		exit(1);
	}

	strcpy(pers_ptr->name, "Kniplitsch");
	pers_ptr->age = 21;
	(*pers_ptr).gender = 'M';

	int group_size = 21;

	person *pers_group = malloc(sizeof(person) * group_size);
	if(pers_group == NULL) {
		printf("Out of memory");
		exit(1);
	}

	pers_group[0] = p1;
	strcpy(pers_group[1].name, "Beck");
	pers_group[1].age = 22;
	pers_group[1].gender = 'M';

	free(pers_group);
	free(pers_ptr);
	
	return 0;
}