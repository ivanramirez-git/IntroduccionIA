#include <bits/stdc++.h>
using namespace std;

struct REGLA{
    char inicio;
    bool einicio;
    char comparacion;
    bool ecomp;
    char cond;
    char conclusion;
};

char validateRule(string rule, vector<char> facts);

int main() {
    cout<<"SISTEMAS EXPERTOS\n";

    //Getting the facts
    char knowFacts='a';
    vector<char> facts;
    while(knowFacts != '0'){
        cout<<"Digite uno a uno los hechos conocidos, 0 para terminar: ";
        cin>>knowFacts;
        facts.push_back(knowFacts);
    }

    //Deficion de las reglas
    vector<REGLA> rules;

    for (int i = 0; i < 6; ++i) {
        cout<<"Ponga el caracter 1\n caracter 2\n estado de 1 -> 1 true\nestado de 2 -> 1 true\nOperador 1->&, 2->O\nCaracter conlusion\n\n";
        REGLA regla;
        cin>>regla.inicio;
        cin>>regla.comparacion;
        int e;
        cin>>e;
        if(e == 1){
            regla.einicio = true;
        }else{
            regla.einicio = false;
        }
        cin>>e;
        if(e == 1){
            regla.ecomp = true;
        }else{
            regla.ecomp = false;
        }

        cin>>regla.cond;
        cin>>regla.conclusion;

        rules.push_back(regla);
    }


    for (int i = 0; i < 6; ++i) {
        if(rules[i].cond == 1){
            if((buscar(rules[i].inicio,rules[i].einicio,facts)  && (buscar(rules[i].comparacion,rules[i].ecomp,facts)))){
                facts.push_back(rules[i].conclusion);
            }
        }else if(rules[i].cond == 2){

        }
    }

    return 0;
}

bool buscar(char i, bool ie, vector<char> facts){
    if(ie){
        find
    }
}
