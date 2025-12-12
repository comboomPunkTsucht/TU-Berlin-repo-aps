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

	# Vorname:
	# Nachname:
	# Matrikelnummer:

	#+ Loesungsabschnitt
	#+ -----------------

.data

test_shift: .word 5
test_text: .asciiz "Bsp Txt1!"

.text

ceasar:

	jr $ra
