import "STree.dart";
import "Rule.dart";
import "Item.dart";
import "Grammar.dart";

class State {
	Grammar grammar;
	State parent;
	Set<Item> items;

	State(Grammar grammar, State parent, Set<Item> items) {
		this.grammar = grammar;
		this.parent = parent;
		this.items = this.complete(items);
	}

	int get numItems {
		return items.length;
	}

	State advance(String symbol, STree sTree) {
		var newItems = new Set<Item>();
		this.scan(symbol, sTree, newItems);
		return new State(this.grammar, this, newItems);
	}

	void scan(String symbol, STree sTree, Set<Item> newItems) {
		for (var item in this.items) {
			var nextItem = item.shift(symbol, sTree);
			if (nextItem != null) newItems.add(nextItem);
		}
	}

	Set<Item> complete(items) {
		bool repeat = true;

		while (repeat) {
			repeat = false;
			var newItems = new Set();

			for (var item in items) {
				if (item.nextSymbol == null) {
					item.origin.scan(item.rule.lhs, item.reduce(), newItems);
					repeat = true;
				} else {
					newItems.add(item);
					this._addPredictions(item.nextSymbol, newItems);
				}
			}

			items = newItems;
		}

		return items;
	}

	void _addPredictions(String symbol, Set<Item> newItems) {
		Set<Rule> predictions = this.grammar.getPredictions(symbol);
		for (var rule in predictions) {
			var item = new Item(this, null, rule, 0, null);
			newItems.add(item);
		}
	}

	String toString() {
		var s = new StringBuffer("State:\n");
		for (var item in this.items) {
			s.write("\t${item}\n");
		}
		return s.toString();
	}
}
