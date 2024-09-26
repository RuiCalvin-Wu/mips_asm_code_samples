.data
    prompt_input_firstCord: .asciiz "Enter the first coordinates (x1,y1):\n"
    prompt_input_secondCord: .asciiz "Enter the second coordinate (x2,y2):\n"
    prompt_output_result: .asciiz "The distance is:\n"

.text
.globl main

main:

    # print the input prompt for first Cord
    li $v0, 4                   
    la $a0, prompt_input_firstCord
    syscall

    # read x1
    li $v0, 5
    syscall
    move $t0, $v0

    # read y1
    li $v0, 5
    syscall
    move $t1, $v0

    # print the input prompt for second Cord
    li $v0, 4
    la $a0, prompt_input_secondCord
    syscall

    # read x2
    li $v0, 5
    syscall
    move $t2, $v0

    # read y2
    li $v0 , 5
    syscall
    move $t3, $v0


    # caluclate (x1-x2) and (y1-y2)
    sub $s1, $t0, $t2           # $s1 is (x1-x2)
    sub $s2, $t1, $t3           # $s2 is (y1-y2)

    # calculate (x1-x2)^2 and (y1-y2)^2
    mul $s1, $s1, $s1           # $s1 = $s1 * $s1
    mul $s2, $s2, $s2           # $s2 = $s2 * $s2

    # add the (x1-x2)^2 and (y1-y2)^2
    add $s3, $s1, $s2           # n = (x1-x2)^2 + (y1-y2)^2, let n be $s3




    # exit here
    li $v0, 10
    syscall


 square_root:
    
    move $t0, $s3               # $t0 will be x
    li $t1, 0                   # $t1 = counter for interations (i)
    div $t2, $s3, 2             # #t2 = n/2
    
while_loop:
    # when i > n/2, we will exit the while loop
    bge $t1, $t2, exit_loop

    


    add $t1, $t1, 1

    j while_loop
exit_loop:








    
    







    
    