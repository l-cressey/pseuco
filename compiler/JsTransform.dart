import "Context.dart";
import "../parser/STree.dart";

class JsTransform {
	Context _context;
	List<JsTransform> _children;
	String _js;

	JsTransform(Context context, STree sTree) {
		this._context = context;
		this._children = [];

		for (var child in sTree.children) {
			var xChild = new JsTransform(context, child);
			this._children.add(xChild);
		}

		this._js = this._apply(sTree.cmd, sTree.value, this._children);
	}

	String _apply(String cmd, String value, List<JsTransform> children) {
		switch(cmd) {
			case "#NUM": return "$value";
			case "#ID": return this._identifier(value);
			case "add": return children.join("+");
			case "sub": return children.join("-");
			case "mul": return children.join("*");
			case "div": return children.join("/");
			case "set": return "${children[0]} = ${children[1]};";
			case "for": return this._buildFor(children); 
			case "statementList": return children.join("\n");
			default:
				if (children.length == 1) return children[0].toString();
				throw new Exception("Not sure how to handle node: $cmd");
		}
	}	

	String _identifier(String name) {
		return this._context.getAddVar(name);
	}

	String _buildFor(List children) {
		var start = this._context.addTempVar();
		var end = this._context.addTempVar();
		var loopIndex = children[0];
		return [
			"var $start = ${children[1]};",
			"var $end = ${children[2]};",
			"for (var $loopIndex = $start; $loopIndex != $end; $loopIndex += 1) {",
			children[3].toString(),
			"}"
		].join("\n");
	}

	String toString() {
		return this._js.toString();
	}
}
