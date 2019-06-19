#Написать программу сложения и умножения двух шестнадцатеричных чисел.
# При этом каждое число представляется как массив, элементы которого — цифры числа.

first = input('Введите первое 16-ричное число: ')
second = input("Введите второе 16-ричное число: ")

list_of_numbers = [str(i) for i in range(10)] + ['A', 'B', 'C', 'D', 'E', 'F']
if len(first) > len(second):
    first, second = second, first
second = second[::-1]
first = first[::-1]
third = []
k = 0
j = 0
for i in second:
    one = list_of_numbers.index(i)
    two = list_of_numbers.index(first[j])
    third.append(list_of_numbers[(one + two + k) % 16])
    if (one + two) > 15:
        k = 1
    else:
        k = 0
    j += 1
    if j == len(first):
        break

for l in second[j:]:
    one = list_of_numbers.index(l)
    third.append(list_of_numbers[(one + k) % 16])
    if (one + k) > 15:
        k = 1
    else:
        k = 0

if k == 1:
    third.append('1')

print(f' Сумма чисел равна {third[::-1]} ')