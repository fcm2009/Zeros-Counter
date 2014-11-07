###############################################################################
.data
	input_string: .asciiz "Enter A Decimal Integer	> "
	output_string: .asciiz "Number of Zeros		> "
###############################################################################
.globl main
.text
	main:
		li $v0, 4	#print input string
		la $a0, input_string
		syscall
		
		li $v0, 5	#read integer
		syscall
		move $a0, $v0
		
		jal count_zeros	#get number of zeros
		move $t0, $v0
		
		li $v0, 4	#print output string
		la $a0, output_string
		syscall

		
		li $v0, 1	#print number of zeros
		move $a0, $t0
		syscall
		
		li $v0, 10	#exit
		syscall
###############################################################################
#Method Name:	count_zeros
#input:		$a0 = number to count it's zeros
#output:	$v0 = number of leading zeros in $a0
###############################################################################
	
	count_zeros:
		move $t0, $a0
		li $t1, 0x80000000		#initialize a to 0x80000000
		li $v0, 0			#count = 0
		
		for:
			and $t2, $t0, $t1
			bgtz $t2, end
			add $v0, $v0, 1
			srl $t1, $t1, 1
			bgtz $t1, for
		end:
			jr $ra
			