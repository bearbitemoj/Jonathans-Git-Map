
#ifndef LAB_1_H_INCLUDED
#define LAB_1_H_INCLUDED

class Lab_1{

//member functions go *inside* the class declaration
public:
	Lab_1();
	void main();

private:
	void inputs();
	void create_tax_table(float, float, float, float);
	float round(float);
};

#endif
