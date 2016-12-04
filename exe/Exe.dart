import '../Env.dart';

abstract class Exe {
	int _ref;

	Exe(int ref) {
		this._ref = ref;
	}

	int get ref { return this._ref; }

	run(Env env);
}
