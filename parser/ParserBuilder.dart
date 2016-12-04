import "STree.dart";
import "Tokeniser.dart";
import "State.dart";
import "Grammar.dart";
import "Item.dart";
import "Parser.dart";

class ParserBuilder {
	Tokeniser _tokeniser;
	Grammar _grammar;

	ParserBuilder(eolSymbol) {
		this._tokeniser = new Tokeniser(eolSymbol);
		this._grammar = new Grammar();
	}

	void addKeywords(List<String> keywords) {
		for (String keyword in keywords) {
			this._tokeniser.addKeyword(keyword);
		}
	}

	void addRules(List<String> rules) {
		for (String ruleText in rules) {
			this._grammar.addRule(ruleText);
		}
	}

	Parser build(bool isDebugMode) {
		this._grammar.close();
		Set<String> symbols = this._grammar.getSymbols();

		for (var symbol in symbols) {
			if (!symbol.startsWith("#")) continue;
			symbol = symbol.substring(1);
			this._tokeniser.addKeyword(symbol);
		}

		return new Parser(this._tokeniser, this._grammar, isDebugMode);
	}
}
