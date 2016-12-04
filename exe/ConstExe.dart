import '../Env.dart';
import 'Exe.dart';

class ConstExe extends Exe {
	var _value;

	ConstExe(int ref, value) : super(ref) {
		this._value = value;
	}

	run(Env env) {
		return this._value;
	}
}
