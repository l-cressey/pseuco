class Rule {
	final int ruleId;
	final String lhs;
	final List<String> rhs;
	final String name;

	const Rule(int this.ruleId, this.lhs, this.rhs, this.name);

	int get length {
		return rhs.length;
	}

	String getSymbolAt(int pos) {
		return (pos < this.length) ? this.rhs[pos] : null;
	}

	String toItemString(int dotPos) {
		var preDot = this.rhs.sublist(0, dotPos).join(" ");
		var postDot = this.rhs.sublist(dotPos).join(" ");
		return "Item(${this.lhs} : ${preDot} . ${postDot})";
	}

	String toString() {
		var rhs = this.rhs.join(" ");
		return "Rule(${this.lhs} : ${rhs}";
	}
}
