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

	# Vorname:
	# Nachname:
	# Matrikelnummer:

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

test_text: .asciiz "Apfel"

.text

bloom_evaluate:

	jr $ra
