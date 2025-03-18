#include <iostream>

#include <string>

#include <bits/stdc++.h>

using namespace std;

string   calc_resestance(string resistor);

bool     is_valid_connection(string resistor);

bool     is_valid_connection_2(string resistor);

float    calculate_series_resistors(string resistor);

float    calculate_parallel_resistors(string resistor);

int main() {

    string resistor ;

getline(cin,resistor);

if(is_valid_connection(resistor))

{

    if(count(resistor.begin(),resistor.end(),'e')>1)

  resistor=calc_resestance(resistor);

        if ((resistor[0]=='s'||resistor[0]=='S')&&calculate_series_resistors(resistor)>0) 

        cout<< "The total resistance = "<<calculate_series_resistors(resistor);

        

        else if ((resistor[0]== 'p'||resistor[0]=='P')&&calculate_parallel_resistors(resistor)>0)

         cout<< "The total resistance = "<<calculate_parallel_resistors(resistor);

       

else{

    cout << "Incorrect Input";

    return 0;

}

}

else{

    cout << "Wrong Description";

    return 0;

    }

return 0;

}

string calc_resestance(string resistor)

    {

int i=2, x=0 , y=0;

    string  sub ;

int counts=0;

do

{

  while (i<resistor.size())

{

       if (resistor[i]=='s'||resistor[i]=='S'||resistor[i]=='p'||resistor[i]=='P')

    {

        x=i;

        break;

    }

      i++  ;

}

y=resistor.find('e'),

sub=resistor.substr(x,y-x+1);

if (sub[0]=='p'||sub[0]=='P')

{

   sub=to_string(calculate_parallel_resistors(sub));

}

if (sub[0]=='S'||sub[0]=='s')

{

  sub=to_string(calculate_series_resistors(sub));

}

resistor.replace(x,y-x+1,sub);

counts = count(resistor.begin(),resistor.end(),'e');

}

while(counts>1);

return resistor;

}

bool is_valid_connection(string resistor) {

    bool valid = true;

    for (int i = 0; i < resistor.size(); i++) {

if (!(resistor[i] == ' '||resistor[i] == '.'|| resistor[i] == 'p' ||resistor[i] == 'e' ||resistor[i] == 'P'|| resistor[i] == 's' ||resistor[i] == 'S' || (resistor[i] >= '0' && resistor[i] <= '9')))

            {

            valid = false;

            break;

            }

    }

    return valid;

}

bool is_valid_connection_2(string resistor)

{

    int i=0 ,spacenum=0 , mini=0;

   while (i < resistor.size())

   {

       if(resistor[i]==' ')

       {

           spacenum++ ;

       }

                i++;

   }

   if (resistor[0]=='s'||resistor[0]=='S')mini=2;

   if (resistor[0]=='p'||resistor[0]=='P')mini=3;

         if (spacenum<mini)

         return true ;

      else

      return false ;

    }

float calculate_series_resistors(string resistor)

{

    if(is_valid_connection_2(resistor))

    {

        return -1 ;

    }

    string restring ;

     int i=0 ,n=0 ,f=0 ;

    float sum=0 ,res_num ;

     resistor=resistor.substr(2);

           while (i < resistor.size()&&resistor[i]!='e')

      {

          if(resistor[i]==' ')

        {

           restring=resistor.substr(n,f) ;

            res_num = stof(restring);

            n=f+1;

            sum+=res_num;

        }

        f++;

        i++;

      }

      return sum ;

}

float calculate_parallel_resistors(string resistor)

{

    if(is_valid_connection_2(resistor))

    {

        return -1 ;

    }

    string  restring ;

     int i=0 ,n=0 ,f=0 ;

    float sum=0 ,res_num ;

  resistor=resistor.substr(2);

           while (i < resistor.size()&&resistor[i]!='e')

      {

          if(resistor[i]==' ')

        {

           restring=resistor.substr(n,f) ;

            res_num = stof(restring);

            n=f+1;

            sum+=1/res_num;

        }

        f++;

        i++;

      }

      return 1/sum ;

}