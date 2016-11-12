import "Rule.dart";
import "Item.dart";

class Grammar {
	static RegExp _SEPARATOR = new RegExp(r"[:]");
	static RegExp _WHITESPACE = new RegExp(r"\s+");

	int numRules;
	Set<String> symbols = new Set<String>();
	Map<String, Set<Rule>> predictions = new Map<String, Set<Rule>>();

	Grammar() {
		numRules = 0;
	}

	void close() {
		var hasChanged = true;

		while (hasChanged) {
			hasChanged = false;
			for (var symbol in this.symbols) {
				var ruleSet = this.predictions[symbol];
				var oldLength = ruleSet.length;
				for (var rule in new Set.from(ruleSet)) {
					var firstSymbol = rule.getSymbolAt(0);
					ruleSet.addAll(predictions[firstSymbol]);
				}
				if (ruleSet.length != oldLength) hasChanged = true;
			}
		}
	}

	Rule addRule(String ruleText) {
		var fields = ruleText.split(Grammar._SEPARATOR);
		if (fields.length < 2) return null;

		var lhsFields = fields[0].trim().split(Grammar._WHITESPACE);
		var name = lhsFields[0];
		var lhs = lhsFields[lhsFields.length == 1 ? 0 : 1];
		var rhsFields = fields[1].trim().split(Grammar._WHITESPACE);

		print("LHS = $lhs NAME = $name RHS = $rhsFields");

		this.addSymbol(lhs);
		for (var symbol in rhsFields) this.addSymbol(symbol);

		var rule = new Rule(this.numRules++, lhs, rhsFields, name);
		this.predictions[lhs].add(rule);

		return rule;
	}

	void addSymbol(String symbol) {
		if (this.symbols.add(symbol)) {
			this.predictions[symbol] = new Set<Rule>();
		}
	}

	Set<Rule> getPredictions(String symbol) {
		return this.predictions[symbol];
	}

	Set<String> getSymbols() {
		return this.symbols;
	}
}
