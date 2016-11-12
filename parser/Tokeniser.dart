class Tokeniser {
	Set<int> _alphas = new Set();
	Set<int> _digits = new Set();
	Set<int> _operators = new Set();
	String _eolSymbol;
	Map<String, String> _keywords = new Map();

	int _codepoint;
	List<int> _text;
	int _lineNumber;
	String _error;
	int _charIndex;
	dynamic _value;

	Tokeniser(eolSymbol) {
		this._alphas.addAll("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_".codeUnits);
		this._digits.addAll("0123456789".codeUnits);
		this._operators.addAll("<>+-*/=!'\"".codeUnits);
		this._eolSymbol = eolSymbol;
	}

	void addKeyword(String keyword) {
		this._keywords[keyword] = "#$keyword";
	}

	dynamic get value {
		return _value;
	}

	String get error {
		return this._error;
	}

	void raiseError(String message) {
		if (this._error == null) {
			this._error = "Error on line ${this._lineNumber}: ${message}";
		}
	}

	void setText(String text) {
		this._codepoint = 0;
		this._text = text.codeUnits;
		this._lineNumber = 1;
		this._error = null;
		this._charIndex = 0;
		this._value = null;
		this.acceptChar();
	}

	String readToken() {
		this._value = null;

		while (this._codepoint > 0 && this._codepoint <= 32) {
			var c = this.acceptChar();
			if (c == 10 && this._eolSymbol != null) return this._eolSymbol;
		}

		if (this._codepoint == 0) {
			return "#EOF";
		} else if (this._alphas.contains(this._codepoint)) {
			var value = this.acceptChars(this._alphas);
			var symbol = this._keywords[value];
			if (symbol != null) return symbol;
			this._value = value;
			return "#ID";
		} else if (this._digits.contains(this._codepoint)) {
			this._value = this.acceptChars(this._digits);
			return "#NUM";
		} else if (this._operators.contains(this._codepoint)) {
			return this.acceptChars(this._operators);
		} else {
			return new String.fromCharCode(this.acceptChar());
		}
	}

	String acceptChars(Set<int> charset) {
		var token = new StringBuffer();

		while (charset.contains(this._codepoint)) {
			token.writeCharCode(this.acceptChar());
		}

		return token.toString();
	}

	int acceptChar() {
		var oldChar = this._codepoint;

		if (this._charIndex < this._text.length) {
			this._codepoint = this._text[this._charIndex];
			this._charIndex += 1;
		} else {
			this._codepoint = 0;
		}

		if (oldChar == 0xa) this._lineNumber += 1;

		return oldChar;
	}
}
