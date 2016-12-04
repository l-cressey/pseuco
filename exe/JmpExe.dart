import '../Env.dart';
import 'Exe.dart';

class JmpExe extends Exe {
	int _lineNo;

	JmpExe(int ref, int lineNo) : super(ref) {
		this._lineNo = lineNo;
	}

	run(Env env) {
		env.jump(this._lineNo);
		return null;
	}
}
