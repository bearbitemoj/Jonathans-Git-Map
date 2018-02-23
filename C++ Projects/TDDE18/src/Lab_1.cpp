
#include <iostream>
using namespace std;

#include "Lab_1.h"

//Constructor
Lab_1::Lab_1(){

}


void Lab_1::main(){
	inputs();

}

void Lab_1::inputs(){
	float firstPrice, lastPrice, stride, taxPercent;

	cout << "INPUT PART" << endl;
	cout << "==========" << endl;
	cout << "Enter first price: ";
	while(!(cin >> firstPrice) || firstPrice < 0){
		cin.clear();
		cin.ignore(1024, '\n');
		if(firstPrice < 0){
			cout << "ERROR: First price must be at least 0 (zero) SEK" << endl;
		}
		cout << "Enter first price: ";
	}

	cout << "Enter last price: ";
	while (!(cin >> lastPrice) || lastPrice <= firstPrice){
		cin.clear();
		cin.ignore(1024, '\n');
		if(lastPrice <= firstPrice){
			cout << "ERROR: Last price must be bigger than first price" << endl;
		}
		cout << "Enter last price: ";
	}

	cout << "Enter stride: ";
	while (!(cin >> stride) || stride < 0.01){
		cin.clear();
		cin.ignore(1024, '\n');
		if(stride < 0.01){
			cout << "ERROR: Stride must be at least 0.01" << endl;
		}
		cout << "Enter stride: ";
	}

	cout << "Enter tax percent: ";
	while (!(cin >> taxPercent) || taxPercent < 0){
		cin.clear();
		cin.ignore(1024, '\n');
		if(taxPercent < 0){
			cout << "ERROR: Tax percent must be at least 0 (zero) percent" << endl;
		}
		cout << "Enter tax percent: ";
	}
	cout << endl;

	create_tax_table(firstPrice, lastPrice, stride, taxPercent);

}

void Lab_1::create_tax_table(float firstPrice, float lastPrice, float stride, float taxPercent){
	int currentPrint=0;
	float numberOfPrints;
	float price, tax, priceWithTax;

	cout << "TAX TABLE" << endl;
	cout << "=========" << endl;
	cout << "	Price		Tax	Price with tax" << endl;
	cout << "-----------------------------------------------" << endl;

	numberOfPrints = (lastPrice - firstPrice)/stride;

	while(currentPrint <= numberOfPrints){
		price = round(firstPrice + stride*currentPrint);
		tax = round((taxPercent/100)*price);
		priceWithTax = round(price + tax);

		cout << "	" << price << "		" << tax << " 		 " << priceWithTax << endl;
		currentPrint++;
	}
}

//Rounds to 2 decimals
float Lab_1::round(float var)
{
    float value = (int)(var * 100 + .5);
    return (float)value / 100;
}


