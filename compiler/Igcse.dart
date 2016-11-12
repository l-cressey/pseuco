import "../parser/ParserBuilder.dart";
import "../parser/Parser.dart";
import "Context.dart";
import "JsTransform.dart";

class Igcse {
	static const _BNF = """
		start : statementList
	
		statementList : statement
		statementList : statementList statement

		for statement : #for #ID = expression #to expression #EOL statementList #next #EOL
		statement : #output expression #EOL
		statement : #input #ID #EOL
		statement : set #EOL

		set : primitive <- expression

		expression : additive

		add additive : additive + multiplicative
		sub additive : additive - multiplicative
		additive : multiplicative

		div multiplicative : multiplicative / primitive
		mul multiplicative : multiplicative * primitive
		multiplicative : primitive

		primitive : #ID
		primitive : #NUM
	""";

	Parser _parser;

	Igcse() {
		var pb = new ParserBuilder("#EOL");
		pb.addRules(Igcse._BNF.split("\n"));
		this._parser = pb.build(true);
	}

	String compile(String source) {
		var sTree = this._parser.compile(source);
		print(sTree);

		Context context = new Context(null);
		var result = new JsTransform(context, sTree);
		return result.toString();
	}
}
