class Env {
	int _lineNo = 0;
	Map _vars = {};
	String _errorMessage = null;

	Env() {
	}

	String get errorMessage { return this._errorMessage; }

	void raiseError(int ref, String message) {
		this._errorMessage = "LINE $ref: $message";
	}

	int incLineNo() {
		int lineNo = this._lineNo;
		this._lineNo += 1;
		return lineNo;
	}

	void jump(int lineNo) {
		this._lineNo = lineNo;
	}

	getVar(int ref, String name) {
		if (!this._vars.containsKey(name)) {
			this._vars[name] = 0;
			this.raiseError(ref, "You tried to use the variable '$name' but you haven't defined it yet.");
		}
		return this._vars[name];
	}

	void setVar(String name, value) {
		this._vars[name] = value;
	}

	String toString() {
		List<String> values = [ "lineNo=${this._lineNo}" ];
		for (String key in this._vars.keys) {
			values.add("$key=${this._vars[key]}");
		}
		return values.join(" ");
	}
}
