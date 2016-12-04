import "../parser/STree.dart";
import "../exe/Exe.dart";
import "../exe/ExeFactory.dart";

class Compiler {
	List<Exe> _lines;
	int _ref;

	Compiler() {
		this._lines = [];
		this._ref = 0;
	}

	List<Exe> get lines { return this._lines; }

	Exe walk(STree tree) {
		switch(tree.cmd) {
			case "#_NUM": return exeConst(this._ref, int.parse(tree.value));
			case "eq": return exeEq(this._ref, this.walk(tree.children[0]), this.walk(tree.children[1]));
			case "add": return exeAdd(this._ref, this.walk(tree.children[0]), this.walk(tree.children[1]));
			case "get": return this._walkGet(tree);
			case "set": return this._walkSet(tree);
			case "if": return this._walkIf(tree);
			case "for": return this._walkFor(tree);
			case "statement": return this.walk(tree.children[0]);
			case "statementList": return this._walkStatementList(tree);
			case "start": return this.walk(tree.children[0]);
			default: print("ERROR: unrecognised node ${tree.cmd}");
		}
		return null;
	}

	int _addLine(Exe exe) {
		int lineNo = this._lines.length;
		this._lines.add(exe);
		return lineNo;
	}

	List<Exe> _walkChildren(STree tree) {
		List<Exe> children = [];
		for (STree child in tree.children) {
			children.add(this.walk(child));
		}
		return children;
	}

	Exe _walkGet(STree tree) {
		String name = tree.children[0].value;
		return exeGet(this._ref, name);
	}

	Exe _walkSet(STree tree) {
		String name = tree.children[0].value;
		Exe rhs = this.walk(tree.children[1]);
		Exe node = exeSet(this._ref, name, rhs);
		this._lines.add(node);
		return null;
	}

	Exe _walkStatementList(STree tree) {
		for (STree child in tree.children) {
			this.walk(child);
		}
		return null;
	}


	Exe _walkIf(STree tree) {
		Exe testExpression = this.walk(tree.children[0]);
		int lineNo1 = this._addLine(null);
		this.walk(tree.children[1]);

		if (tree.children.length == 2) {
			this._lines[lineNo1] = exeJf(this._ref, testExpression, this._lines.length);
		} else {			
			int lineNo2 = this._addLine(null);
			this._lines[lineNo1] = exeJf(this._ref, testExpression, this._lines.length);
			this.walk(tree.children[2]);
			this._lines[lineNo2] = exeJmp(this._ref, this._lines.length);
		}

		return null;
	}

	Exe _walkFor(STree tree) {
		String name = tree.children[0].value;
		Exe startExpression = this.walk(tree.children[1]);
		Exe endExpression = this.walk(tree.children[2]);

		this._lines.add(exeSet(this._ref, name, startExpression));

		int loopId = this._lines.length;
		String loopLimit = "loopLimit$loopId";
		this._lines.add(exeSet(this._ref, loopLimit, endExpression));

		int startLineNo = this._lines.length;
		this._lines.add(null);
		this.walk(tree.children[3]);

		Exe loopInc = exeGet(this._ref, name);
		loopInc = exeAdd(this._ref, loopInc, exeConst(this._ref, 1));
		loopInc = exeSet(this._ref, name, loopInc);
		this._lines.add(loopInc);

		this._lines.add(exeJmp(this._ref, startLineNo));
		int exitLineNo = this._lines.length;
		Exe lhs = exeGet(this._ref, name);
		Exe rhs = exeGet(this._ref, loopLimit);
		this._lines[startLineNo] = exeJeq(this._ref, lhs, rhs, exitLineNo);
	}
}
