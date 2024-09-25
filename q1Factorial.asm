.data 
    prompt_input: .asciiz "Enter the non-negative number:\n"
    factorial_output: .asciiz "Factorial is: \n"
    newline: .asciiz "\n"
    
.text
.globl main

main:
    # print the input message
    li $v0, 4
    la $a0, prompt_input
    syscall

    # read the integer input
    li $v0, 5               
    syscall
    move $t0, $v0                   # move the integer from the return reg to the temp reg

    # init the factorial result to 1 (fact = 1) => the most base case
    li $t1, 1                       # $t1 will hold the factorial result

    # init loop counter
    li $t2, 1                       # $t2 is the loop counter (i)

fact_loop:
    # check if counter exceeds the input number
    bgt $t2, $t0, output_result     # if i>n, go to print_result - base case => if $t0 is 0 print fact(1) = 1

    # Multiply fact by i
    mul $t1, $t1, $t2               # fact = fact*i
    
    # increment the counter
    addi $t2, $t2, 1                # i++

    # repeat loop
    j fact_loop


output_result:
    # print the result
    li $v0, 4
    la $a0, factorial_output
    syscall

    # print the output
    move $a0, $t1
    li $v0, 1
    syscall

    # print new line
    li $v0, 4
    la $a0, newline
    syscall

    #exit program
    li $v0, 10              
    syscall

