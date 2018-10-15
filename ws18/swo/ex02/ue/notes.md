# Konstanten in C
* #define MAX_LEN 10
* const int MAX_LEN=10;

# Literale
* int: 0, -1
* long: 0L, 0l
* unsigned: u0, u0l
* float \| double: 1.0, 1f, 10.3e5f
* char: 'a', '\n'

## Zeichenketten
"abc\n" = "abc\xA"
"\0" = Terminalisierung

# Typen in C
## Typendekl.
[const][sign-qualifier][size-qualifier][base-type] var;
		signed			short			char
		unsigned		long			int
						long long		float
										double
int
long int
unsigned int
long double

## Implizite Typkonversion
´´
short s;
char c;
int i;
float f;
double d,r;

r=(c/s)+(f*d)-(f-i);
   i i	 d	     f
	i	 d		f
	d			d
		 d
### Explizite Typkonversion
TBD
# Master Theorem
T(n) = 3T(n/2)+O(n^1)
T(n) = ?
a = 3
b = 2
c = 1
c_crit = log(3>1)
T(n) = O(n^log(3)) = O(n^1.53)