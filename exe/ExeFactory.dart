import 'Exe.dart';
import 'GetExe.dart';
import 'SetExe.dart';
import 'EqExe.dart';
import 'AddExe.dart';
import 'JmpExe.dart';
import 'JeqExe.dart';
import 'JneExe.dart';
import 'JfExe.dart';
import 'ConstExe.dart';
import 'ErrorExe.dart';

Exe exeGet(int ref, String name) { return new GetExe(ref, name); }

Exe exeSet(int ref, String name, Exe child) { return new SetExe(ref, name, child); }

Exe exeEq(int ref, Exe lhs, Exe rhs) { return new EqExe(ref, lhs, rhs); }

Exe exeAdd(int ref, Exe lhs, Exe rhs) { return new AddExe(ref, lhs, rhs); }

Exe exeJmp(int ref, int lineNo) { return new JmpExe(ref, lineNo); }

Exe exeJeq(int ref, Exe lhs, Exe rhs, int lineNo) { return new JeqExe(ref, lhs, rhs, lineNo); }

Exe exeJne(int ref, Exe lhs, Exe rhs, int lineNo) { return new JneExe(ref, lhs, rhs, lineNo); }

Exe exeJf(int ref, Exe condition, int lineNo) { return new JfExe(ref, condition, lineNo); }

Exe exeConst(int ref, var value) { return new ConstExe(ref, value); }

Exe exeError(int ref, String value) { return new ErrorExe(ref, value); }
