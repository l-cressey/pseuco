class STree {
	String _cmd;
	String _value;
	List<STree> _children;

	STree.node(String cmd, List<STree> children) {
		this._cmd = cmd;
		this._value = null;
		this._children = children;
	}

	STree.leaf(String cmd, String value) {
		this._cmd = cmd;
		this._value = value;
		this._children = [];
	}

	STree.error(int lineNumber, String message) {
		this._cmd = "err";
		this._value = message;
		this._children = [];
	}

	String get cmd {
		return this._cmd;
	}

	String get value {
		return this._value;
	}

	List<STree> get children {
		return this._children;
	}

	void _writeString(StringBuffer sb, int indent) {
		sb.write(" " * indent);

		if (this._value != null) {
			sb.write("${this._cmd} ${this._value}:\n");
		} else {
			sb.write("${this._cmd}:\n");
		}

		for (STree child in this._children) {
			child._writeString(sb, indent + 4);
		}
	}

	String toString() {
		StringBuffer sb = new StringBuffer();
		this._writeString(sb, 0);
		return sb.toString();
	}
}
