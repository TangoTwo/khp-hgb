# Strukturen
## Deklaration
struct struct_name {
	type_1 comp_1
	type_2 comp_2
}

oder

typedef struct [struct_name] {
	...
} struct_name

## Definition
struct struct_name v1, pv1;

oder

struct_name v1, *pv1;

## Zugriff auf comp
v1.comp1
pv1->comp1
(*pv1).comp1