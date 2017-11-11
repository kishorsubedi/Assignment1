.data 

str:    
    .space 9 #8 bits for 8 characters and 1 bit for end 
    
.text 

li $v0, 8 #v0 code 8 means OS expects to input a string from user
la $a0, str #address of str in memory store in register  $a0 
li $a1, 9 #OS knows 9 bits string is about to get inputted 
syscall #Call to the system 
#By this point, user input string is stored in memory, and that address is in register $a0
