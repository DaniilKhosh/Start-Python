#Массив размером 2m + 1, где m – натуральное число, заполнен случайным образом.
# Найдите в массиве медиану. Медианой называется элемент ряда,
# делящий его на две равные части: в одной находятся элементы,
# которые не меньше медианы, в другой – не больше медианы.
import random

size = int(input('Введите нечетное целое число для определения размера массива.'))
min_item = -100
max_item = 100
array = [random.randint(min_item, max_item) for _ in range(size)]
print(f' Сгенерированный массив: {array} ')

#Шейкерная сортировка
def shaker(array):
    up = range(len(array) - 1)
    while True:
        for mass in (up, reversed(up)):
            sw = False
            for i in mass:
                if array[i] > array[i+1]:
                    array[i], array[i+1] =  array[i+1], array[i]
                    sw = True
            if not sw:
                return array

print(f' Упорядоченный массив : {shaker(array)} ')

print(f' Медиана массива: {array[int(len(array) / 2)]} ')

