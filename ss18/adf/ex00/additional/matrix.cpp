#include <iostream>
#include <vector>
#include <string>

using namespace std;

    std::vector< vector<int> > firstVec, secondVec, resultVec;
    int m,n,o = 0;
    
void printVec(std::vector< vector<int> > vector){
    for(int row = 0; row < vector.size(); row++){
        for(int col = 0; col < vector[0].size(); col++)
        {
            std::cout << vector[row][col] << " ";
        }
        std::cout << std::endl;
    }
}
int read() {
    std::cout << "Please enter m" << std::endl;
    std::cin >> m;
    std::cout << "Please enter o" << std::endl;
    std::cin >> o;
    std::cout << "Please enter n" << std::endl;
    std::cin >> n;
    
    firstVec.resize(m,vector<int>(o,0));
    secondVec.resize(o,vector<int>(n,0));
    resultVec.resize(m,vector<int>(n,0));
    
    for(int row = 0; row < m; row++){
        for(int col = 0; col < o; col++)
        {
            std::cout << "Please enter "<< row+1 << col+1 << " of the first vector" << endl;
            std::cin >> firstVec[row][col];
        }
    }
    for(int row = 0; row < o; row++){
        for(int col = 0; col < n; col++)
        {
            std::cout << "Please enter "<< row+1 << col+1 << " of the second vector" << endl;
            std::cin >> secondVec[row][col];
        }
    }
    std::cout << "Done with vectoring" << std::endl;
}
void multiply(){
    int tResult = 0;
    for(int row = 0; row < m; row++){
        for(int col = 0; col < n; col++){
            for(int count = 0; count < o; count++){
                    tResult = tResult + (firstVec[row][count]*secondVec[count][col]);
            }
            resultVec[row][col] = tResult;
            tResult = 0;
        }
    }
}
void print(){
    printVec(resultVec);
}
int main() {
    read();
    multiply();
    print();
    return 0;
}
