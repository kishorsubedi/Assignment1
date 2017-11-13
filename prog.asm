.data 
    prompt: .asciiz "Enter a string:\n"
    user_input:    .space 9 #max 8 characters + 1 end character
    str1: .asciiz "Invalid number" 
    
.text 

    li $v0, 4 #call code for printing out a string
    la $a0, prompt #address of prompt put in argument register $a0
    syscall $Displays the prompt 
    
    la $t0, user_input #address of user_inputs in memory store in register #$t0 now has the address of user_input 
    
    li $v0, 8 #v0 code 8 means OS expects to input a string from user
    la $a0, $t0    #$a0 has value in $t0 
    li $a1, 9 #OS knows max length of user input string
    syscall #Call to the system 
#By this point, user input string is stored in memory, and that address is in register $a0



