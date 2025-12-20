	#+ BITTE NICHT MODIFIZIEREN: Vorgabeabschnitt
	#+ ------------------------------------------

.data

str_text: .asciiz "Text: "
str_shift: .asciiz "\nShift: "
str_verschluesselt: .asciiz "\nVerschluesselter Text: "

.text

.eqv SYS_PUTSTR 4
.eqv SYS_PUTCHAR 11
.eqv SYS_PUTINT 1
.eqv SYS_EXIT 10

main:
	# Eingabe Text wird ausgegeben:
	li $v0, SYS_PUTSTR
	la $a0, str_text
	syscall

	li $v0, SYS_PUTSTR
	la $a0, test_text
	syscall

	# Eingabe Shift wird ausgegeben:
	li $v0, SYS_PUTSTR
	la $a0, str_shift
	syscall

	li $v0, SYS_PUTINT
	la $a0, test_shift
	lw $a0, 0($a0)
	syscall

	li $v0, SYS_PUTSTR
	la $a0, str_verschluesselt
	syscall

	move $v0, $zero
	# Aufruf der Funktion ceasar:
	la $a0, test_text
	la $a1, test_shift
	lw $a1, 0($a1)
	jal ceasar

	# Verschlüsselter Text wird ausgegeben:
	li $v0, SYS_PUTSTR
	la $a0, test_text
	syscall

	# Ende der Programmausfuehrung:
	li $v0, SYS_EXIT
	syscall

	#+ BITTE VERVOLLSTAENDIGEN: Persoenliche Angaben zur Hausaufgabe
	#+ -------------------------------------------------------------

	# Vorname: Fabian
	# Nachname: Aps
	# Matrikelnummer: 525528

	#+ Loesungsabschnitt
	#+ -----------------

.data

test_shift: .word 5
test_text: .asciiz "Bsp Txt1!"

.text

ceasar:
	# $a0 = text pointer
	# $a1 = shift value

	move $t0, $a0		# $t0 = current character pointer

loop:
	lbu $t1, 0($t0)		# $t1 = current character
	beqz $t1, done		# if null terminator, done

	# Check if uppercase letter (A-Z: 65-90)
	li $t2, 65		# 'A'
	li $t3, 90		# 'Z'
	blt $t1, $t2, check_lower
	bgt $t1, $t3, check_lower

	# Handle uppercase letter
	sub $t1, $t1, $t2	# convert to 0-25
	add $t1, $t1, $a1	# add shift
	li $t4, 26
	div $t1, $t4
	mfhi $t1		# modulo 26
	add $t1, $t1, $t2	# convert back to ASCII
	sb $t1, 0($t0)		# store result
	j next

check_lower:
	# Check if lowercase letter (a-z: 97-122)
	li $t2, 97		# 'a'
	li $t3, 122		# 'z'
	blt $t1, $t2, check_digit
	bgt $t1, $t3, check_digit

	# Handle lowercase letter
	sub $t1, $t1, $t2	# convert to 0-25
	add $t1, $t1, $a1	# add shift
	li $t4, 26
	div $t1, $t4
	mfhi $t1		# modulo 26
	add $t1, $t1, $t2	# convert back to ASCII
	sb $t1, 0($t0)		# store result
	j next

check_digit:
	# Check if digit (0-9: 48-57)
	li $t2, 48		# '0'
	li $t3, 57		# '9'
	blt $t1, $t2, next
	bgt $t1, $t3, next

	# Handle digit
	sub $t1, $t1, $t2	# convert to 0-9
	add $t1, $t1, $a1	# add shift
	li $t4, 10
	div $t1, $t4
	mfhi $t1		# modulo 10
	add $t1, $t1, $t2	# convert back to ASCII
	sb $t1, 0($t0)		# store result

next:
	addi $t0, $t0, 1	# move to next character
	j loop

done:
	jr $ra
