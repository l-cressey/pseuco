import '../Env.dart';
import 'Exe.dart';

class SetExe extends Exe {
	String _name;
	Exe _child;

	SetExe(int ref, String name, Exe child) : super(ref) {
		this._name = name;
		this._child = child;
	}

	run(Env env) {
		var value = this._child.run(env);
		env.setVar(this._name, value);
		return value;
	}
}
