#В массиве случайных целых чисел поменять местами минимальный и максимальный элементы

import random

SIZE=10 # здесь задаем размер массива
MIN_ITEM=0
MAX_ITEM=100
a =[random.randint(MIN_ITEM,MAX_ITEM) for _ in range(SIZE)]
print(a)
min=0
max=0
i=1
while i <=SIZE-1:
    if a[i]<a[min]:
        min=i
    elif a[i]>a[max]:
        max=i
    i+=1
print(f"max element: a[{max}]={a[max]}  min element: a[{min}]={a[min]}")
a[max],a[min]=a[min],a[max]
print("Change place: \n",(a))
