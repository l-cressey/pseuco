import '../Env.dart';
import 'Exe.dart';

class GetExe extends Exe {
	String _name;

	GetExe(int ref, String name) : super(ref) {
		this._name = name;
	}

	run(Env env) {
		return env.getVar(this.ref, this._name);
	}
}
