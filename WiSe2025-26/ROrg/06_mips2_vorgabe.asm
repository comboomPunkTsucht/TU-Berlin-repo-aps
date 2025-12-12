.data

x:               .word    4
n:               .word    5
str:             .asciiz  "abc 123rtv045"
array:           .word    -1, 0, 78, 14, 9, 13, -18, 55, -8, 48, -11, 11
len:             .word    12

# singly linked list
elem_A: .word  elem_C , 0
elem_B: .word  elem_F , 1
elem_C: .word  elem_E , 2
elem_D: .word  elem_B , 3
elem_E: .word  elem_D , 4
elem_F: .word       0 , 7


.text

##########################################
##  Aufgabe 6.2  #########################
##########################################
#
# Diese Funktion soll das Arbeiten
# mit Bitmustern üben. Es gibt
# viele Wege zum Ziel!
#
##########################################
# int exp(int x, int n)
# {
#     int z = 1;
#     while (n > 0) {
#         if ((n&1) == 0) {
#             x = x*x;
#             n = n>>1;
#         } else {
#             z = z*x;
#             n--;
#         }
#     }
#     return z;
# }
##########################################
exp:
	jr   $ra

##########################################
##  Aufgabe 6.3  #########################
##########################################
# int number_of_numbers(char str[])
# {
#     int count = 0, i = 0, last_char_is_digit = 0; /* false */
#
#     while (str[i] != '\0') {
#         if (!last_char_is_digit && isdigit(str[i]))
#             count++;
#         last_char_is_digit = isdigit(str[i]);
#         i++;
#     }
#
#     return count;
# }
##########################################
number_of_numbers:
	jr   $ra                         # return

##########################################
##  Aufgabe 6.4  #########################
##########################################
# int foo(int a[], int n)
# {
#     int i, j;
#     for (i = 0; i < n-1; i++)
#         for (j = i+1; j < n; j++)
#             if (a[i] == a[j])
#                 return j;
#     return n;
# }
##########################################
foo:
	jr   $ra                         # return (j in $v0)

##########################################
##  Aufgabe 6.5  #########################
##########################################
# void clip(int array[], int len)
# {
#     int i;
#
#     for (i = 0; i < len; i++) {
#         if (array[i] < 10)
#             array[i] = 10;
#     }
# }
##########################################
clip:
	jr   $ra                         # return

##########################################
##  Aufgabe 6.6  #########################
##########################################
# struct element {
#    struct element *next;
#    int value;
# };
#
# int get_last(struct element *list)
# {
#     struct element *tmp;
#     tmp = list;
#     while (tmp->next != null)
#         tmp = tmp->next;
#     return tmp->value;
# }
##########################################
get_last:
	jr   $ra                         # return tmp->value

##########################################
##  Aufgabe 6.7  #########################
##########################################
# int fib(int n)
# {
#     if (n < 2)
#         return n;
#     else
#         return fib(n-1) + fib(n-2);
# }
##########################################
fib:
	jr   $ra

##########################################
##  Main  ################################
##########################################
.data

str_cmd_start:   .asciiz  "Start\n"
str_cmd_62:      .asciiz  "\nAufgabe 6.2 (number_of_numbers):\n"
str_cmd_63:      .asciiz  "\nAufgabe 6.3 (exp):\n"
str_cmd_64:      .asciiz  "\nAufgabe 6.4 (foo):\n"
str_cmd_65:      .asciiz  "\nAufgabe 6.5 (clip):\n"
str_cmd_66:      .asciiz  "\nAufgabe 6.6 (get_last):\n"
str_cmd_67:      .asciiz  "\nAufgabe 6.7 (fib):\n"
str_cmd_end:     .asciiz  "\n\nEnde"

.text

.eqv SYS_PUTSTR 4
.eqv SYS_PUTCHAR 11
.eqv SYS_PUTINT 1
.eqv SYS_EXIT 10


.globl main
main:
	li   $v0, SYS_PUTSTR
	la   $a0, str_cmd_start
	syscall
	
	li   $v0, SYS_PUTSTR
	la   $a0, str_cmd_62	
	syscall

	# set args and call func
	la   $a0, str
	jal  number_of_numbers

	move $a0, $v0
	li   $v0, SYS_PUTINT
	syscall
	
	li   $v0, SYS_PUTSTR
	la   $a0, str_cmd_63
	syscall

	# set args and call func
	la   $a0, x
	lw   $a0, 0($a0)
	la   $a1, n
	lw   $a1, 0($a1)
	jal  exp

	# print return value (should be 4^5 = (2^2)^5 = 1024)
	move $a0, $v0
	li   $v0, SYS_PUTINT
	syscall


	la   $a0, str_cmd_64
	li   $v0, SYS_PUTSTR
	syscall

	# set args and call func
	la   $a0, array
	la   $a1, len
	lw   $a1, 0($a1)
	move $s0, $a0
	jal  foo

	# print array after foo in an optimzed way (works only if len(array)==12)
	li   $s1, 0
main_loop1:
	li   $v0, SYS_PUTINT
	lw   $a0, 0($s0)
	syscall
	addi $s0, $s0, 4
	addi $s1, $s1, 1
	li   $v0, SYS_PUTCHAR
	li   $a0, ','
	syscall
	bne  $s1, $v0, main_loop1
	li   $v0, SYS_PUTINT
	lw   $a0, 0($s0)
	syscall

	li   $v0, SYS_PUTSTR
	la   $a0, str_cmd_65
	syscall

	# set args and call func
	la   $a0, array
	la   $a1, len
	lw   $a1, 0($a1)
	move $s0, $a0
	jal  clip

	# print array after clip in an optimzed way (works only if len(array)==12)
	li   $s1, 0
main_loop2:
	li   $v0, SYS_PUTINT
	lw   $a0, 0($s0)
	syscall
	addi $s0, $s0, 4
	addi $s1, $s1, 1
	li   $v0, SYS_PUTCHAR
	li   $a0, ','
	syscall
	bne  $s1, $v0, main_loop2
	li   $v0, SYS_PUTINT
	lw   $a0, 0($s0)
	syscall

	li   $v0, SYS_PUTSTR
	la   $a0, str_cmd_66
	syscall

	# set args and call func
	la   $a0, elem_A
	jal  get_last

	move $a0, $v0
	li   $v0, SYS_PUTINT
	syscall

	li   $v0, SYS_PUTSTR
	la   $a0, str_cmd_67
	syscall

	# set args and call func
	la   $a0, n
	lw   $a0, 0($a0)
	jal  fib

	# print return value (fib[5] = 5 -> 0,1,1,2,3,5,8,... )
	move $a0, $v0
	li   $v0, SYS_PUTINT
	syscall

	li   $v0, SYS_PUTSTR
	la   $a0, str_cmd_end
	syscall

	li $v0, SYS_EXIT
	syscall


##########################################
##  Hilfsfunktion  #######################
##########################################
isdigit:
	li  $v0, 0
	blt $a0, '0', isdigit_end
	bgt $a0, '9', isdigit_end
	li  $v0, 1
isdigit_end:
	jr  $ra
