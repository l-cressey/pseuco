import 'Pseuco.dart';

main() {
	Pseuco p = new Pseuco.igcse("""
foo <- 1
FOR bob = 1 TO 10
	IF foo = 5 THEN
		foo <- 10
	ENDIF
	foo <- foo + 1
NEXT
	""");

	print("**********************");

	while (p.step() == null) {
		print(p);
	}
}
