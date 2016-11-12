import "STree.dart";
import "Tokeniser.dart";
import "State.dart";
import "Grammar.dart";
import "Item.dart";

class Parser {
	bool _isDebugMode;
	Tokeniser _tokeniser;
	Grammar _grammar;
	State _startState;

	Parser(Tokeniser tokeniser, Grammar grammar, bool isDebugMode) {
		this._tokeniser = tokeniser;
		this._grammar = grammar;
		this._isDebugMode = isDebugMode;

		var startRule = this._grammar.addRule("#START : start #EOF #EOF");
		var startItems = new Set();
		startItems.add(new Item.fromRule(null, startRule));
		this._startState = new State(this._grammar, null, startItems);
	}

	STree compile(source) {
		this._tokeniser.setText(source);
		var state = this._startState;

		while (state.numItems > 0) {
			var symbol = this._tokeniser.readToken();
			var value = this._tokeniser.value;

			if (this._isDebugMode) {
				print("--- READ TOKEN: ${symbol} ${value}");
				print(state);
			}

			var sTree = null;

			if (symbol == "#NUM" || symbol == "#ID") {
				sTree = new STree.leaf(symbol, value);
			}

			state = state.advance(symbol, sTree);
			if (symbol == "#EOF") break;
		}

		if (state.numItems == 0) {
			this._tokeniser.raiseError("Syntax error.");
			return new STree.error(0, "Undefined error");
		} else if (state.numItems > 1) {
			return new STree.error(0, "Ambiguous parse");
		} else {
			return state.items.first.parent.sTree;
		}
	}
}
