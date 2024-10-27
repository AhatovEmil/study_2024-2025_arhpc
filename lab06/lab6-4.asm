%include 'in_out.asm' ; подключение внешнего файла 
 
SECTION .data ; секция инициированных данных
msg: DB 'Введите значение переменной x: ', 0
res: DB 'Результат: ', 0
 
SECTION .bss ; секция неинициированных данных
x: RESB 80 ; Переменная для хранения значения, вводимого с клавиатуры
 
SECTION .text ; Код программы
GLOBAL _start ; Начало программы
_start: ; Точка входа в программу
 
    ; ---- Ввод значения x ----
    mov eax, msg ; Адрес выводимого сообщения в eax
    call sprint ; Вызов подпрограммы для печати сообщения
    mov ecx, x ; Запись адреса переменной x в ecx
    mov edx, 80 ; Указание длины вводимого значения в edx
    call sread ; Вызов подпрограммы для ввода значения
    mov eax, x ; Преобразование ASCII в число
    call atoi ; Преобразование ASCII кода в число, теперь `eax = x`
 
    ; ---- Вычисление выражения (8x - 6) / 2 ----
    mov ebx, 8 ; Установка значения 8 в ebx
    mul ebx ; Умножение: EAX = EAX * EBX = x * 8
    sub eax, 6 ; Вычитание 6: EAX = EAX - 6 = 8x - 6
    mov ebx, 2 ; Установка значения 2 в ebx для деления
    cdq ; Расширение EAX в EDX:EAX для корректной работы div
    div ebx ; Деление: EAX = (8x - 6) / 2, остаток в EDX
 
    ; Сохранение результата в edi для вывода
    mov edi, eax ; Результат вычисления в 'edi'
 
    ; ---- Вывод результата на экран ----
    mov eax, res ; Сообщение 'Результат: '
    call sprint ; Вызов подпрограммы для печати сообщения
    mov eax, edi ; Подготовка результата для печати
    call iprint ; Печать результата в виде числа
    call quit ; Завершение программы
