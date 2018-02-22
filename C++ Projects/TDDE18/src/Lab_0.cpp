//============================================================================
// Name        : Lab_0.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
//============================================================================

#include <iostream>
#include "Lab_0.h"

using namespace std;

class Lab_0{

	//This needs to be added if we want to have main before all other methods and still be able to contact them
	void test_1();
	void test_2();
	void test_3();
	void test_4();
	void test_5();
	void test_6();
	void test_7();
	void test_8();
	void test_9();
	void test_10();
	void test_11();
	void test_12();

	// Member functions definitions including constructor
	Lab_0::Lab_0() {
		// TODO Auto-generated constructor stub


	}

	Lab_0::~Lab_0() {
		// TODO Auto-generated destructor stub
	}


	void test_1(){
		int a;

		cout << "Enter one integer: ";
		cin >> a;
		cout << "You entered the number: " << a << endl;
	}

	void test_2(){
		int a,b,c,d;

		cout << "Enter four integers: ";
		cin >> a;
		cin >> b;
		cin >> c;
		cin >> d;
		cout << "You entered the numbers: " << a << " "<< b << " " << c << " " << d << endl;

	}

	void test_3(){
		int a;
		double a_d;

		cout << "Enter one integer and one real number: ";
		cin >> a;
		cin >> a_d;

		cout << "The real is: " << a_d << endl;
		cout << "The integer is: " << a << endl;

	}

	void test_4(){
		int a;
		double a_d;

		cout << "Enter one real and one integer number: ";
		cin >> a_d;
		cin >> a;

		cout << "The real is: " << a_d << endl;
		cout << "The integer is: " << a << endl;

	}

	void test_5(){
		char a;

		cout << "Enter a character: ";
		cin >> a;
		cout << "You entered: " << a << endl;
	}

	void test_6(){
		string a;

		cout << "Enter a word: ";
		cin >> a;
		cout << "The word '" << a << "' has " << a.length() << " character(s)" << endl;
	}

	void test_7(){
		int a;
		string a_str;

		cout << "Enter an integer and a word: ";
		cin >> a;
		cin >> a_str;
		cout << "You entered '" << a << "' and '" << a_str << "'" << endl;
	}

	void test_8(){
		char a;
		string a_str;

		cout << "Enter an character and a word: ";
		cin >> a;
		cin >> a_str;
		cout << "You entered the string \"" << a_str << "\" and the character '" << a << "'" << endl;

	}

	void test_9(){
		string a_str;
		double a_d;

		cout << "Enter a word and a real number: ";
		cin >> a_str;
		cin >> a_d;
		cout << "You entered \"" << a_str << "\" and \"" << a_d << "\"" << endl;

	}

	void test_10(){
		string a_str;

		cout << "Enter a text-line: ";

		getline (cin, a_str);

		cout << "You entered: \"" << a_str << "\"" << endl;
	}

	void test_11(){
		string a_str;

		cout << "Enter a second line of text: ";

		getline (cin, a_str);

		cout << "You entered: \"" << a_str << "\"" << endl;
	}

	void test_12(){
		string a_str, b_str, c_str;

		cout << "Enter three words: ";
		cin >> a_str;
		cin >> b_str;
		cin >> c_str;

		cout << "You entered: '" << a_str << " " << b_str << " " << c_str << "'" << endl;
	}

};
