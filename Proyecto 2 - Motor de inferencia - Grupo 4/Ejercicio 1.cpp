#include <iostream>
#include <cmath>

using namespace std;

int digital_root(int num){
	int cont=0;
	while(true){
		
		cont+=num%10;
		cout<<cont<<endl;		
		num=num/10;
		if(cont<10&&num==0)
			return cont;
		if(num==0)
			num=cont;
		if(num==cont)
			cont=0;
	}
}

int main(){
	cout<<digital_root(493193)<<endl;
	return 0;
}
