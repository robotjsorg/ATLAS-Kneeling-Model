// JOE IS WORKING ON THIS.

#include <iostream>
#include <fstream>
using namespace std;

int main() {
	// READ THE MATLAB FILE
	streampos size;
	char * memblock;

	ifstream file ( "../MATLAB/1_Position_Kinematics/q_Matrix_1.m", ios::in|ios::binary|ios::ate);
	if (file.is_open())
	{
		size = file.tellg();
		memblock = new char [size];
		file.seekg (0, ios::beg);
		file.read (memblock, size);
		file.close();

		cout << "the entire file content is in memory";

		// OUTPUT IT TO A NEW FILE
		ofstream myfile ("../q_Matrix_1.cpp");
		if (myfile.is_open())
		{
			cout << memblock;

			// CONVERT IT TO A C++ ARRAY

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