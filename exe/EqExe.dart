import '../Env.dart';
import 'Exe.dart';

class EqExe extends Exe {
	Exe _lhs;
	Exe _rhs;

	EqExe(int ref, Exe lhs, Exe rhs) : super(ref) {
		this._lhs = lhs;
		this._rhs = rhs;
	}

	run(Env env) {
		var lhs = this._lhs.run(env);
		var rhs = this._rhs.run(env);
		return lhs == rhs;
	}
}
