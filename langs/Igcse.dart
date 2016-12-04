import '../exe/Exe.dart';
import "../parser/ParserBuilder.dart";
import "../parser/Parser.dart";
import "../compiler/Compiler.dart";

class Igcse {
	static const _BNF = """
		start : statementList
	
		statementList : statement
		statementList : statementList statement

		for statement : #FOR #_ID = expression #TO expression #EOL statementList #NEXT #EOL

		if ifBody : expression #THEN #EOL statementList #ELSEIF ifBody
		if ifBody : expression #THEN #EOL statementList #ELSE #EOL statementList #ENDIF #EOL
		if ifBody : expression #THEN #EOL statementList #ENDIF #EOL

		statement : #IF ifBody
		statement : #OUTPUT expression #EOL
		statement : #INPUT #ID #EOL
		statement : set #EOL

		set : #_ID <- expression

		nop expression : comparative

		eq comparative : additive = additive
		ne comparative : additive < > additive
		nop comparative : additive

		add additive : additive + multiplicative
		sub additive : additive - multiplicative
		nop additive : multiplicative

		div multiplicative : multiplicative / primitiveRhs
		mul multiplicative : multiplicative * primitiveRhs
		nop multiplicative : primitiveRhs

		get primitiveRhs : #_ID
		nop primitiveRhs : #_NUM
	""";

	Parser _parser;

	Igcse() {
		var pb = new ParserBuilder("#EOL");
		pb.addRules(Igcse._BNF.split("\n"));
		this._parser = pb.build(true);
	}

	List<Exe> compile(String source) {
		var sTree = this._parser.compile(source);
		print(sTree);

		Compiler compiler = new Compiler();
		compiler.walk(sTree);
		return compiler.lines;
	}
}
