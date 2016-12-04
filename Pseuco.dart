import 'Env.dart';
import 'exe/Exe.dart';
import 'exe/ExeFactory.dart';
import 'langs/Igcse.dart';

class Pseuco {
	List<Exe> _lines;
	Env _env;

	Pseuco.igcse(String srcCode) {
		Igcse compiler = new Igcse();
		this.setLines(compiler.compile(srcCode));
		this._env = new Env();
	}

	void setLines(List<Exe> lines) {
		this._lines = lines;
		this._lines.add(exeError(0, "Your program has finished running."));
	}

	step() {
		int lineNo = this._env.incLineNo();
		Exe line = this._lines[lineNo];
		line.run(this._env);
		return this._env.errorMessage;
	}

	String toString() {
		return this._env.toString();
	}
}

