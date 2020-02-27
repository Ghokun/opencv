#include <iostream>
#include <opencv2/opencv.hpp>
using namespace std;
using namespace cv;
int main() {
    cout << CV_VERSION
         << "("
         << CV_MAJOR_VERSION
         << "."
         << CV_MINOR_VERSION
         << "."
         << CV_SUBMINOR_VERSION
         << ")
         << endl;
    return 0;
}	 
