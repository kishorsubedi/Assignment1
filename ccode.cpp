//9 integers to be converted s
to_check_list = {0,1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f','A','B','C','D','E','F'};

for(int i=0; i<size(string); i++)
{
    if string[i] not in to_check_list:
        cout << "Invalid Number" << endl;
        return ;
}

summ = 0 ;
index = 0;
for (int i=size(string)-1; i>=0; i--):#'103F'
{
    summ += 16**index * string[i] ;
    index ++ ;
}
return summ
    
    
