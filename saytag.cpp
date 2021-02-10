#include <iostream>
#include <sstream>
#include <bitset>
#include <string>
using namespace std;

//program extracts tag, line word and offset fields from hexadecimal 32 bit direction
int main()
{
    string s;
    ulong tag, line, word, offset;
    printf("Input tag, line, word and offset fields (decimal) or 87 to finish\n");
    cin >> tag >> line >> word >> offset;
    while (s.compare("87") != 0)
    {
        cout <<"Input hexadecimal"<< '\n';
        cin >> s;
        stringstream ss;
        ss << hex << s;
        unsigned n;
        ss >> n;
        //change to 64 for 64 bit processor addressing
        bitset<32> b(n);
        ulong q = (b>>(line+word+offset)).to_ulong() ;
        cout << "Tag: " << hex << q << endl;
        ulong c = q<<line;//c size is tag+line, it has the tag copied and line are 0s
        cout << "Line: " << hex << ((b>>(word+offset)).to_ulong()&(~c)) << endl;
        c|=(b>>(word+offset)).to_ulong();//c is size tag+line, it has both copied
        c<<=word;//and it has 0s in word now 
        cout << "Word: " << hex<< ((b>>(offset)).to_ulong()&(~c)) << endl;
        c|=(b>>offset).to_ulong();//c is size tag+line+word and it has all of them copied
        c<<=offset;//and it is 0 in offset field
        cout << "Offset: " << hex<< (b.to_ulong() & (~c)) << endl;
    }
    return 0;
}