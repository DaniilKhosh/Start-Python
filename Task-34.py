# Определить, какое число в массиве встречается чаще всего.

import random

SIZE=15 # здесь задаем размер массива
MIN_ITEM=0
MAX_ITEM=100
a =[random.randint(MIN_ITEM,MAX_ITEM) for _ in range(SIZE)]
print(a)

n = a[0]
max= 1
for i in range(SIZE-1):
    c = 1
    for k in range(i+1,SIZE):
        if a[i] == a[k]:
            c += 1
    if c > max:
        max = c
        num = a[i]

if max > 1:
    print(f"Число {num} встречается {max} раз(-а)")
else:
    print('Числа не повторяются')