#include <iostream>
#include <vector>
#include <cmath>
using namespace std;

class Bisection {
public:
    vector<double> coeff;
    double n, t, a, b;
    Bisection(vector<double> _coeff, double _n, double _t, double _a, double _b) :
        coeff{_coeff}, n{_n}, t{_t}, a{_a}, b{_b} {}

    double bisection() {
        double fa=0, fb=0, fc=0;
        double c=(a+b)/2.0;
        do {
            fa=fx(a); //-1.1
            fb=fx(b); //1.3
            fc=fx(c); //0.2
            if(fa*fc>0) {
                a=c;
            }
            else {
                b=c; //b=0
            }
            c=(a+b)/2;
            cout<<c<<endl;
        } while(abs(fc)>=t);
        return c;
    }

    double fx(double x) {
        double sum=0;
        for(int i=0; i<=n; i++) {
            sum+=(coeff.at(i))*(power(x, i));
        }
        return sum;
    }

    double power(double x, int y) {
        double pow_sum=x;
        if(y==0) {
            return 1;
        }
        else if(y==1) {
            return x;
        }
        else {
            for(int i=1; i<y; i++) {
                pow_sum*=x;
            }
            return pow_sum;
        }
    }
};

int main() {
    vector<double> coeff={0.2, 3.1, -0.3, 1.9, 0.2};
    Bisection bisect=Bisection(coeff, 4, 0.01, -1, 1);
    double output=bisect.bisection();
    cout<<output<<endl;
}