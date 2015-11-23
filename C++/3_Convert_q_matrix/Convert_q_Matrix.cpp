#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <fstream>
using namespace std;

#include <cstring>

const int MAX_CHARS_PER_LINE = 512;
const int MAX_TOKENS_PER_LINE = 20;
const char* const DELIMITER = " ,;[]=\t";

int lines() {
  ifstream fin;
  fin.open("../../MATLAB/q_Matrix_1.m");

  int lines = 0;
  std::string line;

  while (std::getline(fin, line))
      ++lines;

  return lines;
}

int main()
{
  ifstream fin;
  fin.open("../../MATLAB/q_Matrix_1.m");
  lines();
  int lines_counter = 0;

  ofstream myfile ("../q_Matrix_1.cpp");

  if (!fin.good()) 
    return 1;

  const char* token[MAX_TOKENS_PER_LINE] = {};

  myfile << "double q_matrix[3][" << lines() << "] = {" << endl;

  while (!fin.eof())
  {
    char buf[MAX_CHARS_PER_LINE];
    fin.getline(buf, MAX_CHARS_PER_LINE);
    
    int n = 0;
    
    token[0] = strtok(buf, DELIMITER);
    if (token[0])
    {
      for (n = 1; n < MAX_TOKENS_PER_LINE; n++)
      {
        token[n] = strtok(0, DELIMITER);
        if (!token[n]) break;
      }
    }

    myfile << "{";
    for (int i = 0; i < n; i++)
    {
      cout << token[i] << endl;
      if (strncmp(token[i], "q_matrix", 8))
      {
        if (i<n-1)
        {
          myfile << token[i] << ", ";
        } else
        {
          myfile << token[i];
        }
      }
    }
    if(lines_counter == lines())
    {
      myfile << "}" << endl;
    }
    else
    {
      myfile << "}," << endl;
    }

    lines_counter++;
  }
  myfile << "};";
  myfile.close();

  return 0;
}