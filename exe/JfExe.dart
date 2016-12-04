import '../Env.dart';
import 'Exe.dart';

class JfExe extends Exe {
	Exe _condition;
	int _lineNo;

	JfExe(int ref, Exe condition, int lineNo) : super(ref) {
		this._condition = condition;
		this._lineNo = lineNo;
	}

	run(Env env) {
		if (this._condition.run(env) != true) {
			env.jump(this._lineNo);
		}
		return null;
	}
}
