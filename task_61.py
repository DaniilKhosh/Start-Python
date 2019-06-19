# В массиве найти максимальный отрицательный элемент.
# Вывести на экран его значение и позицию в массиве.

import random
import sys

SIZE = 10
MIN_ITEM = -850
MAX_ITEM = -750
array = [random.randint(MIN_ITEM, MAX_ITEM) for _ in range(SIZE)]
print(array)

# вариант 1
i = 0
index = -100500
while i < len(array):   # или for i in range(len(array)):
    if array[i] < 0 and index == -100500:
        index = i
    elif 0 > array[i] > array[index]:
        index = i
    i += 1

if index != -1:
    print(f'Максимальное отрицательное число {array[index]} '
          f'находится в ячейке {index}')

print(f"\nSize of SIZE is {sys.getsizeof(SIZE)}")
print(f"Size of MIN_ITEM is {sys.getsizeof(MIN_ITEM)}")
print(f"Size of MAX_ITEM is {sys.getsizeof(MAX_ITEM)}")
print(f"Size of i is {sys.getsizeof(i)}")
print(f"Size of index is {sys.getsizeof(index)}")
print(f"Size of array is {sys.getsizeof(array)}")
k = 0
for i in range(SIZE):
    print(f'Size of array[{i}] is {sys.getsizeof(array[i])}')
    k += sys.getsizeof(array[i])
print(f'\nCommon memory for 1 case: {sys.getsizeof(SIZE) + sys.getsizeof(MIN_ITEM) + sys.getsizeof(MAX_ITEM) + sys.getsizeof(i) + sys.getsizeof(index) + sys.getsizeof(array) + sys.getsizeof(k) + k}\n')

# вариант 2
num = float('-inf')
for i, item in enumerate(array):
    if 0 > item > num:
        num = item
        index = i

if num != float('-inf'):
    print(f'Максимальное отрицательное число {num} '
          f'находится в ячейке {index}')


print(f"\nSize of num is {sys.getsizeof(num)}")
print(f"Size of item is {sys.getsizeof(item)}")
print(f"Size of enumerate is {sys.getsizeof(enumerate)}")
print(f'\nCommon memory for 2 case: {sys.getsizeof(SIZE) + sys.getsizeof(MIN_ITEM) + sys.getsizeof(MAX_ITEM) + sys.getsizeof(i) + sys.getsizeof(item) + sys.getsizeof(num) + sys.getsizeof(enumerate) + k} ')

print("\nВо втором случае памяти выделяется больше за счет использования словаря enumerate")