#include <iostream>
#include <string>

int fib(int n) {
	if (n < 2)
		return 1;
	return fib(n - 1) + fib(n - 2);
}

int main(int argc, char* argv[]) {
	if (argc != 2) {
		std::cout <<
			"expected:\n"
			"  fib_test <number>\n"
			"got " << (argc - 1) << " arguments instead\n";
		return -1;
	}
	std::cout << fib(std::stoi(argv[1])) << std::endl;
	return 0;
}

