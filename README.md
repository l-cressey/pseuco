# Pseuco

Students on the IGCSE and IB Computer Science qualifications need to
demonstrate that they can write pseudo-code to the exam-board
specifications.

Pseuco is a compiler for these pseudo-code languages.
It is written in [Google Dart](http://www.dartlang.org).
At the moment, only the IGCSE specification is implemented and there
are a few missing constructs.

It uses an Earley parser to simplify grammar specification and allow
matching common error patterns.

## Future plans
- Complete the IGCSE spec.
- Implement the specifications for IB and A-level, including library API's.
- Upgrade the code representation which is currently flabby.
- Lexical scoping.
- Implement some other pedagogical languages.

