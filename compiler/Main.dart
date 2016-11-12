import "Igcse.dart";

main() {
	Igcse compiler = new Igcse();

	var js = compiler.compile("for bob = 1 to 10\nfoo <- foo + 1 / 7\nnext\n");
	print("**********************");
	print(js);
}
