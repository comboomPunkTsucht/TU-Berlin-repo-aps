	#+ BITTE NICHT MODIFIZIEREN: Vorgabeabschnitt
	#+ ------------------------------------------

.data

str_text: .asciiz "Text: "
str_rueckgabewert: .asciiz "\nRueckgabewert: "

.text

.eqv SYS_PUTSTR 4
.eqv SYS_PUTCHAR 11
.eqv SYS_PUTINT 1
.eqv SYS_EXIT 10

main:
	# Eingabe text wird ausgegeben:
	li $v0, SYS_PUTSTR
	la $a0, str_text
	syscall

	li $v0, SYS_PUTSTR
	la $a0, test_text
	syscall

	li $v0, SYS_PUTSTR
	la $a0, str_rueckgabewert
	syscall

	move $v0, $zero
	# Aufruf der Funktion bloom_evaluate:
	la $a0, test_text
	la $a1, test_bitmatrix
	la $a2, test_amt
	lw $a2, 0($a2)
	jal bloom_evaluate

	# Rueckgabewert wird ausgegeben:
	move $a0, $v0
	li $v0, SYS_PUTINT
	syscall

	# Ende der Programmausfuehrung:
	li $v0, SYS_EXIT
	syscall

	# Hilfsfunktion: int hash(char* text, int len, int seed)
hash:
	move $v0, $a2
	li $t0, 3
_hash_outer_loop:
	ble $t0, $zero, _hash_outer_loop_end

	li $t1, 0
_hash_inner_loop:
	bge $t1, $a1, _hash_inner_loop_end

	li $t2, 31
	mult $v0, $t2
	mflo $v0
	add $t2, $a0, $t1
	lbu $t3, 0($t2)
	add $v0, $v0, $t3
	sll $t2, $v0, 15
	srl $t3, $v0, 17
	or $v0, $t2, $t3

	addi $t1, $t1, 1
	j _hash_inner_loop
_hash_inner_loop_end:
	addi $t0, $t0, -1
	j _hash_outer_loop
_hash_outer_loop_end:
	jr $ra

	#+ BITTE VERVOLLSTAENDIGEN: Persoenliche Angaben zur Hausaufgabe
	#+ -------------------------------------------------------------

	# Vorname: Fabian
	# Nachname: Aps
	# Matrikelnummer: 525528

	#+ Loesungsabschnitt
	#+ -----------------

.data

test_amt: .word 4

test_bitmatrix:
	.word 0x10000020
	.word 0x04009440
	.word 0x02064224
	.word 0x08000240
	.word 0x02008420

test_text: .asciiz "MIPS"

.text

bloom_evaluate:
	# $a0 = text pointer
	# $a1 = bitmatrix pointer
	# $a2 = amt (number of hash calls)

	# Save registers on stack
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)		# text pointer
	sw $s1, 8($sp)		# bitmatrix pointer
	sw $s2, 12($sp)		# amt
	sw $s3, 16($sp)		# len
	sw $s4, 20($sp)		# current seed

	move $s0, $a0		# save text pointer
	move $s1, $a1		# save bitmatrix pointer
	move $s2, $a2		# save amt

	# Step 1: Count string length
	move $t0, $s0		# pointer to text
	li $s3, 0		# len = 0
count_loop:
	lbu $t1, 0($t0)		# load character
	beqz $t1, count_done	# if null terminator, done
	addi $s3, $s3, 1	# len++
	addi $t0, $t0, 1	# next character
	j count_loop
count_done:

	# Step 2 & 3 & 4: Hash amt times and check bits
	li $s4, 0		# seed = 0

hash_loop:
	bge $s4, $s2, all_bits_set	# if seed >= amt, all bits were set

	# Call hash(text, len, seed)
	move $a0, $s0		# text
	move $a1, $s3		# len
	move $a2, $s4		# seed
	jal hash

	# $v0 contains hash value
	# Calculate row = hash mod 5
	li $t0, 5
	div $v0, $t0
	mfhi $t1		# $t1 = row

	# Calculate col = hash mod 32
	li $t0, 32
	div $v0, $t0
	mfhi $t2		# $t2 = col

	# Load bitmatrix[row]
	sll $t3, $t1, 2		# row * 4 (word offset)
	add $t3, $s1, $t3	# bitmatrix + row*4
	lw $t4, 0($t3)		# $t4 = bitmatrix[row]

	# Create bitmask (1 << col)
	li $t5, 1
	sllv $t5, $t5, $t2	# $t5 = 1 << col

	# Check if bit is set
	and $t6, $t4, $t5
	beqz $t6, not_found	# if bit not set, return 0

	addi $s4, $s4, 1	# seed++
	j hash_loop

not_found:
	li $v0, 0		# return 0
	j bloom_done

all_bits_set:
	li $v0, 1		# return 1

bloom_done:
	# Restore registers from stack
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	addi $sp, $sp, 24

	jr $ra
