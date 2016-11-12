import "STree.dart";
import "Rule.dart";
import "State.dart";

class Item {
	State origin;
	Item parent;
	Rule rule;
	STree sTree;
	int dotPos;
	String nextSymbol;

	Item(this.origin, this.parent, this.rule, this.dotPos, this.sTree) {
		this.nextSymbol = this.rule.getSymbolAt(this.dotPos);
	}

	Item.fromRule(State this.origin, Rule this.rule) {
		this.parent = null;
		this.dotPos = 0;
		this.sTree = null;
		this.nextSymbol = this.rule.getSymbolAt(0);
	}

	STree reduce() {
		if (this.dotPos != this.rule.length) return null;
		var children = [];
		for (var item = this; item != null; item = item.parent) {
			var sTree = item.sTree;
			if (sTree != null) children.insert(0, sTree);
		}
		return new STree.node(this.rule.name, children);
	}

	Item shift(String symbol, STree sTree) {
		if (this.nextSymbol == symbol) {
			return new Item(this.origin, this, this.rule, this.dotPos + 1, sTree);
		}
	}

	String toString() {
		return this.rule.toItemString(this.dotPos);
	}

	int get hashCode {
		return rule.ruleId * 256 + dotPos;
	}

	bool operator ==(other) {
		if (other is! Item) return false;
		Item item = other;
		return this.rule == other.rule && this.dotPos == other.dotPos;
	}
}
