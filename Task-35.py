#В одномерном массиве найти сумму элементов, находящихся между минимальным и
# максимальным элементами. Сами минимальный и максимальный элементы в сумму не включать.
import random

SIZE=15 # здесь задаем размер массива
MIN_ITEM=0
MAX_ITEM=100
a =[random.randint(MIN_ITEM,MAX_ITEM) for _ in range(SIZE)]
print(a)

min = 0
max = 0
for i in range(1,SIZE):
    if a[i] < a[min]:
        min = i
    elif a[i] > a[max]:
        max = i
print(f"Минимальное значение : {a[min]}, максимальное значение: {a[max]}")


if min > max:
    min, max = max, min
    s=0
    for i in range(min+1, max):
      s += a[i]
print(f"Сумма между числами равна: {s}")