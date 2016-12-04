class Context {
	Context _parent;
	int _depth;
	int _uniqueId;
	Map<String, String> _localVars;

	Context(Context parent) {
		this._parent = parent;
		this._uniqueId = 0;
		this._localVars = {};
		this._depth = (parent != null) ? parent._depth + 1 : 0;
	}

	String getAddVar(String name) {
		var jsName = this.getVar(name);
		if (jsName == null) jsName = this.addVar(name);
		return jsName;
	}

	String addVar(String name) {
		var jsName = addTempVar();
		this._localVars[name] = jsName;
		return jsName;
	}

	String addTempVar() {
		var id = this._uniqueId++;
		var jsName = "v_${this._depth}_$id";
		return jsName;
	}

	String getVar(String name) {
		String jsName = null;

		for (Context c = this; c != null; c = c._parent) {
			jsName = c._localVars[name];
		}

		return jsName;
	}
}
