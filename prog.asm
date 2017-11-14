.data 
    prompt: .asciiz "Enter a string:\n"
    user_input:    .space 8 #max 8 characters 
    invalid_prompt: .asciiz "Invalid number" 
    valid_prompt:   .asciiz "Valid hexadecimal number"
.text 

    li $v0, 4 #call code for printing out a string
    la $a0, prompt #address of prompt put in argument register $a0
    syscall #Displays the prompt 
    
    la $t0, user_input #address of user_inputs in memory store in register #$t0 now has the address of user_input 
    
    li $v0, 8 #v0 code 8 means OS expects to input a string from user
    la $a0, ($t0)    #$a0 has value in $t0 
    li $a1, 9 #OS knows max length of user input string
    syscall #Call to the system 
#By this point, user input string is stored in memory, and that address is in register $a0
    addi $t7, $t0, 8 #$t7 holds the 9th byte from user_input address, to check all the characters have gone through validation
    
    target:

        lb $t1, 0($t0) #loaded 1st byte of memory into $t1
        blt $t1, 48, invalid #branch to invalid label if $t1 is less than 48 
        blt $t1, 58, valid
        blt $t1, 65, invalid
        blt $t1, 71, valid
        blt $t1, 97, invalid
        blt $t1, 103, valid
        bgt $t1, 102, invalid
    
    invalid: #Prompts "Invalid Number" and program exits
        li $v0, 4 
        la $a0, invalid_prompt 
        syscall 
        li $v0, 10 
        syscall 
        
    valid: #Prompts something and program exits 
        addi $t0, $t0, 1 # $t0 is immediately increased by 1 
        bne $t0, $t7, target #If $t0 != $t7, there's still more characters to be checked out.
        
        li $v0, 4 
        la $a0, valid_prompt
        syscall 
        li $v0, 10 
        syscall 
    
    
