import '../Env.dart';
import 'Exe.dart';

class ErrorExe extends Exe {
	String _message;

	ErrorExe(int ref, String message) : super(ref) {
		this._message = message;
	}

	run(Env env) {
		return env.raiseError(0, this._message);
	}
}
