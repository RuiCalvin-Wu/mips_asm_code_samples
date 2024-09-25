.data 
    prompt_input: .asciiz "Enter equation:\n"
    prompt_output: .asciiz "The answer is:\n"
    equation: .space 256

    
.text
.globl main

main:

    # print the input string
    li $v0, 4
    la $a0, prompt_input
    syscall 

    # read the user input
    li $v0, 8
    la $a0, equation        #mem address to store the word
    li $a1 256              #max character
    syscall

    # init register for processing and storing
    li $t0, 0               # will store the running sum (total sum)
    li $t1, 0               # store the current number
    li $t2, 1               # will be used to check the signs (1 for + or -1 for -)
    li $t3, 0               # will store the ASCII code of the current character
    li $t4, 48              # ASCII for 0, we know it will count up by 1.


parse_loop:

    lb $t3, 0($a0)          # loads a byte from mem into register $t3. 0($a0)-> is the mem address from which the byte is loaded from.
    beq $t3, 10, end        # checks if the current character is \n , then it will jump to end seciton if is equal
    beq $t3, 0, end         # checks if the current character is 0, then j into end if is equal

    #checks if character is a digit
    blt $t3, 48, not_digit  # If char is < 0

    # Convert char to integer
    sub $t3, $t3, $t4       # subtracts '0' to get integer value => ($t3-48)=number

    # accumulate the current number to previous denoted $t3
    mul $t1, $t1, 10        # times by 10 cause we know it will be a 2 digit-number
    add $t1, $t1, $t3       # add the second digit of the number to $t1 (the current number)
    j next_char

next_char:
    # move to next character
    addi $a0, $a0, 1        # Move to the next character => adds 1 to $a0 => moves to next character in input string
    j parse_loop

not_digit:
    # handles for + and - cases
    beq $t3, 45, minus_op   # the '-' operator
    beq $t3, 43, add_op     # the '+' operator

minus_op:
    # Subtract the current number to the running sum
    mul $t1, $t1, $t2       # apply the signs to the current number
    add $t0, $t0, $t1       # add current number to total sum
    li $t1, 0               # reset current number
    li $t2, -1              # set sign to negative for next number
    j next_char             

add_op:
    # add the current mumber to the running sum.
    mul $t1, $t1, $t2       # apply the signs to the current number
    add $t0, $t0, $t1       # Add current number to total sum
    li $t1, 0               # reset current number
    li $t2, 1               # Set signs to negative for next week.
    j next_char


end:
    # final addition after parsing
    mul $t1, $t1, $t2       # Apply the last number's sign 
    add $t0, $t0, $t1       # Add the last number to the running total

    # print the output prompt
    li $v0, 4
    la $a0, prompt_output
    syscall

    # print the output integer
    li $v0, 1
    move $a0, $t0           # move the running sum (total sum) to syscall argument $a0
    syscall

    # Exit program
    li $v0, 10              # syscall code for exit
    syscall






