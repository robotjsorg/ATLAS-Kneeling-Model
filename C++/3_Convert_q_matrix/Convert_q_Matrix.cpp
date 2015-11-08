// JOE IS WORKING ON THIS.

#include <iostream>
#include <fstream>
using namespace std;

// 
int main() {
	// READ THE MATLAB FILE
	streampos size;
	char * memblock;

	ifstream file ( "../MATLAB/Position_Kinematic/q_matrix_1.m", ios::in|ios::binary|ios::ate);
	if (file.is_open())
	{
		size = file.tellg();
		memblock = new char [size];
		file.seekg (0, ios::beg);
		file.read (memblock, size);
		file.close();

		cout << "the entire file content is in memory";

		// CONVERT TO C++ ARRAY

		// OUTPUT IT TO A NEW FILE
		ofstream myfile ("example.txt");
		if (myfile.is_open())
		{
			myfile << "This is a line.\n";
			myfile << "This is another line.\n";
			myfile.close();
		}
		else cout << "Unable to open file";

		delete[] memblock;
	}
	else cout << "Unable to open file";

return 0;
}

double convert_q_matrix[]() {

}