#include <iostream>
#include <vector>
#include <sstream>
#include <cctype>

using namespace std;


struct REGLA {
    string regla;
    bool estado;
    vector<string> componentes;
};

void listarExpresiones(vector<vector<REGLA>> expresiones);
void agregarRegla(vector<vector<REGLA>>* exp);
void getValidateRule(REGLA* pRegla);
void searchRuleMatch(vector<vector<REGLA>>& pVector, REGLA* pRegla,int &posx);

int main() {
    vector<string> v1;
    v1.push_back("h");
    v1.push_back("o");
    v1.push_back("l");
    vector<string> v2;
    v2.push_back("h");
    v2.push_back("o");
    v2.push_back("l");

    cout << ((v1 == v2) ? "Si" : "No");
    cout << "MOTOR DE INFERECIA LOGICA\n\n";
    int select = 1;

    vector<vector<REGLA>> expresiones;
    REGLA expValid;
    int posx;
    while (select != 0)
    {
        select = 0;
        cout << "\nMenu principal\n 0.Salir\n 1.Agregar regla\n 2.Listar reglas\n 3.Validar condicion\n Su opcion:";
        cin >> select;
        switch (select)
        {
            case 1:
                agregarRegla(&expresiones);
                break;

            case 2:
                cout << "Las reglas en sistema son :\n";
                listarExpresiones(expresiones);
                break;

            case 3:
                int posx;
                searchRuleMatch(expresiones,&expValid,posx);
                while(1 != expresiones[posx].size()){
                    //    eliminar(expresiones,posx);
                }
                break;

            case 0:
                cout << "Saliendo del programa\n";
                break;

            default:
                break;
        }
    }

    return 0;
}

void searchRuleMatch(vector<vector<REGLA>>& pVector, REGLA* pRegla, int &posx) {
    vector<string> variablesSolucionadas;
    for (int i = 0; i < pVector.size(); ++i) {
        for (int j = 0; j < pVector[i].size(); ++j) {
            if (pVector[i][j].regla == pRegla->regla) {
                posx = i;
                variablesSolucionadas = pVector[i][j].componentes;
            }
        }
    }

    for (int i = 0; i < pVector.size(); ++i) {
        for (int j = 0; j < pVector[i].size(); ++j) {
            for (int k = 0; k < variablesSolucionadas.size(); ++k) {
                for (int l = 0; l < pVector[i][j].componentes.size(); ++l) {
                    if (pVector[i][j].componentes[l] == variablesSolucionadas[k]) {
                        pVector[i][j].componentes[l] = pRegla->componentes[k];
                    }
                }
            }
        }
    }

}

void getValidateRule(REGLA* pRegla) {
    cout << "\nDe el nombre de la regla a validar: ";
    string input;
    cin.ignore();
    getline(cin, input);
    pRegla->regla = input;
    char resp = 'n';
    while ((cout << "\nLa regla estará negada? (s/n): ") //make sure the user knows what you expect
           && getline(cin, input)
           && !(istringstream{ input } >> resp) //construct a stringstream from `line` and read it into `num`
           && (resp == 's' || resp == 'n')
            ) //this loop continues on bad input and ends on good input
    {
        std::cerr << "\nInput nvalido. Intente nuevamente." << std::endl; //let the user know they made a mistake
    }
    resp == 's' ? pRegla->estado = false : pRegla->estado = true;
    int num;
    cout << "Cuantos componentes tiene su regla: ";
    cin >> num;


    cin.ignore();
    for (int i = 0; i < num; ++i) {
        cout << "Digite el " << i + 1 << "componente: ";
        getline(cin, input);
        pRegla->componentes.push_back(input);
    }
}

void listarExpresiones(vector<vector<REGLA>> exp) {
    for (int i = 0; i < exp.size(); ++i) {
        cout << "Expresion " << i + 1 << ": \n";
        for (int j = 0; j < exp[i].size(); j++)
        {
            if (!exp[i][j].estado) {
                cout << "¬";
            }
            cout << exp[i][j].regla << "(";
            for (int k = 0; k < exp[i][j].componentes.size(); ++k) {
                if (k == 0) {
                    cout << exp[i][j].componentes[k];
                }
                else {
                    cout << "," << exp[i][j].componentes[k];
                }
            }
            cout << ")";
            if (!(exp[i].size() == j + 1)) {
                cout << " V ";
            }
        }
        cout << "\n";
    }
}


void agregarRegla(vector<vector<REGLA>>* exp)
{
    vector<REGLA>* reglas = new vector<REGLA>();
    string input;
    int num = 0;
    cin.ignore(1);
    while ((cout << "\nDigite el numero de reglas en su expresion: ") //make sure the user knows what you expect
           && getline(cin, input)
           && !(istringstream{ input } >> num) //construct a stringstream from `line` and read it into `num`
            ) //this loop continues on bad input and ends on good input
    {
        std::cerr << "\nInput nvalido. Intente nuevamente." << std::endl; //let the user know they made a mistake
    }

    for (int i = 0; i < num; i++)
    {
        REGLA r;
        cout << "\nDigite el nombre de la regla: ";
        getline(cin, input);
        r.regla = input;
        char resp = 'n';
        while ((cout << "\nLa regla estará negada? (s/n): ") //make sure the user knows what you expect
               && getline(cin, input)
               && !(istringstream{ input } >> resp) //construct a stringstream from `line` and read it into `num`
               && (resp == 's' || resp == 'n')
                ) //this loop continues on bad input and ends on good input
        {
            std::cerr << "\nInput nvalido. Intente nuevamente." << std::endl; //let the user know they made a mistake
        }
        resp == 's' ? r.estado = false : r.estado = true;
        int numC = -1;
        while (numC == -1)
        {
            while ((cout << "\nDigite el numero de componentes de su regla: ") //make sure the user knows what you expect
                   && getline(cin, input)
                   && !(istringstream{ input } >> numC) //construct a stringstream from `line` and read it into `num`
                    ) //this loop continues on bad input and ends on good input
            {
                std::cerr << "\nInput nvalido. Intente nuevamente." << std::endl; //let the user know they made a mistake
            }
            switch (numC)
            {
                case 1:

                    cout << "\nDigite el componente: ";
                    getline(cin, input);
                    r.componentes.push_back(input);
                    reglas->push_back(r);
                    break;
                case 2:
                    cout << "\nDigite el componente C1 (C1" << (r.estado ? " " : " no ") << r.regla << " C2): ";
                    getline(cin, input);
                    r.componentes.push_back(input);

                    cout << "\nDigite el componente C2 (" << r.componentes[0] << (r.estado ? " " : " no ") << r.regla << " C2): ";
                    getline(cin, input);
                    r.componentes.push_back(input);
                    reglas->push_back(r);
                    break;

                case 3:
                    cout << "\nDigite el componente C1 (C1" << (r.estado ? " " : " no ") << r.regla << " C2): ";
                    getline(cin, input);
                    r.componentes.push_back(input);

                    cout << "\nDigite el componente C2 (" << r.componentes[0] << (r.estado ? " " : " no ") << r.regla << " C2): ";
                    getline(cin, input);
                    r.componentes.push_back(input);

                    cout << "\nDigite el componente C3 (" << r.componentes[1] << (r.estado ? " " : " no ") << r.regla << " C2): ";
                    getline(cin, input);
                    r.componentes.push_back(input);
                    reglas->push_back(r);
                    break;
                default:
                    cout << "\nNumero de componentes invalido. intente nuevamente.";
                    numC = -1;
            }
        }
    }
    exp->push_back(*reglas);
}

