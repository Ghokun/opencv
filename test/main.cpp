#include <iostream>
#include "nlopt.hpp"
using namespace std;
int main() {
    cout << nlopt::version_major()
         << "."
         << nlopt::version_minor()
         << "."
         << nlopt::version_bugfix()
         << endl;
    return 0;
}
