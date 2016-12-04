import '../Env.dart';
import 'Exe.dart';

class JneExe extends Exe {
	Exe _lhs;
	Exe _rhs;
	int _lineNo;

	JneExe(int ref, Exe lhs, Exe rhs, int lineNo) : super(ref) {
		this._lhs = lhs;
		this._rhs = rhs;
		this._lineNo = lineNo;
	}

	run(Env env) {
		if (this._lhs.run(env) != this._rhs.run(env)) {
			env.jump(this._lineNo);
		}
	}
}
