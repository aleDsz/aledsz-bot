import std.typecons;
import std.random;

class Cassino {
	Tuple!(ulong, ulong, ulong) run() {
		ulong number1 = dice(10);
		ulong number2 = dice(10);
		ulong number3 = dice(10, 1);

		return tuple(number1, number2, number3);
	}
}
