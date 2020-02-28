# В массиве найти максимальный отрицательный элемент.
# Вывести на экран его значение и позицию в массиве.

#--------------------------------------------------------------------------------------
#
#Результаты замеров и профилирования показывают, что зависимость линейная и быстрее
# всего работает функция со вторым вариантом (enumerate)
##---------------------------------------------------------------------------------------

import random
import cProfile


# вариант 1


#"Task_41.first(10000)"
#10 loops, best of 5: 38 msec per loop
#"Task_41.first(20000)"
#10 loops, best of 5: 73.6 msec per loop
#"Task_41.first(30000)"
#10 loops, best of 5: 112 msec per loop
#"Task_41.first(100000)"
#10 loops, best of 5: 372 msec per loop

#ncalls  tottime  percall  cumtime  percall filename:lineno(function)
#1    0.002    0.002    0.490    0.490 <string>:1(<module>)
#1    0.066    0.066    0.489    0.489 Task_41.py:10(first)
#1    0.053    0.053    0.414    0.414 Task_41.py:13(<listcomp>)
#100000    0.136    0.000    0.306    0.000 random.py:174(randrange)
#100000    0.054    0.000    0.360    0.000 random.py:218(randint)
#100000    0.122    0.000    0.171    0.000 random.py:224(_randbelow)
#1    0.000    0.000    0.490    0.490 {built-in method builtins.exec}
#100001    0.009    0.000    0.009    0.000 {built-in method builtins.len}
#100000    0.010    0.000    0.010    0.000 {method 'bit_length' of 'int' objects}
#1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
#183038    0.039    0.000    0.039    0.000 {method 'getrandbits' of '_random.Random' objects}


def first(SIZE):
    MIN_ITEM = -1008000
    MAX_ITEM = 3564098
    array = [random.randint(MIN_ITEM, MAX_ITEM) for _ in range(SIZE)]
    i = 0
    index = -1
    while i < len(array):      # или for i in range(len(array)):
        if array[i] < 0 and index == -1:
            index = i
        elif 0 > array[i] > array[index]:
            index = i
        i += 1
    if index != -1:
        l=array[index]
    return l, index


# вариант 2


#"Task_41.second(10000)"
#10 loops, best of 5: 33 msec per loop
#"Task_41.second(20000)"
#10 loops, best of 5: 65.8 msec per loop
#"Task_41.second(30000)"
#10 loops, best of 5: 98.9 msec per loop
#"Task_41.second(100000)"
#10 loops, best of 5: 322 msec per loop


#ncalls  tottime  percall  cumtime  percall filename:lineno(function)
#1    0.002    0.002    0.436    0.436 <string>:1(<module>)
#1    0.016    0.016    0.434    0.434 Task_41.py:28(second)
#1    0.054    0.054    0.419    0.419 Task_41.py:31(<listcomp>)
#100000    0.136    0.000    0.310    0.000 random.py:174(randrange)
#100000    0.055    0.000    0.365    0.000 random.py:218(randint)
#100000    0.123    0.000    0.173    0.000 random.py:224(_randbelow)
#1    0.000    0.000    0.436    0.436 {built-in method builtins.exec}
#100000    0.010    0.000    0.010    0.000 {method 'bit_length' of 'int' objects}
#1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
#183773    0.040    0.000    0.040    0.000 {method 'getrandbits' of '_random.Random' objects}


def second(SIZE):
    MIN_ITEM = -1008000
    MAX_ITEM = 3564098
    array = [random.randint(MIN_ITEM, MAX_ITEM) for _ in range(SIZE)]
    num = float('-inf')
    for i, item in enumerate(array):
        if 0 > item > num:
            num = item
            index = i
    if num != float('-inf'):
        l = num
    return l, index

# вариант 3

#"Task_41.third(10000)"
#10 loops, best of 5: 37.8 msec per loop
#"Task_41.third(20000)"
#10 loops, best of 5: 77.3 msec per loop
#"Task_41.third(30000)"
#10 loops, best of 5: 113 msec per loop
#"Task_41.third(100000)"
#10 loops, best of 5: 387 msec per loop

#ncalls  tottime  percall  cumtime  percall filename:lineno(function)
#1    0.002    0.002    0.488    0.488 <string>:1(<module>)
#1    0.067    0.067    0.486    0.486 Task_41.py:42(third)
#1    0.053    0.053    0.414    0.414 Task_41.py:45(<listcomp>)
#100000    0.135    0.000    0.307    0.000 random.py:174(randrange)
#100000    0.054    0.000    0.361    0.000 random.py:218(randint)
#100000    0.122    0.000    0.171    0.000 random.py:224(_randbelow)
#1    0.000    0.000    0.488    0.488 {built-in method builtins.exec}
#1    0.000    0.000    0.000    0.000 {built-in method builtins.len}
#1    0.004    0.004    0.004    0.004 {built-in method builtins.max}
#100000    0.010    0.000    0.010    0.000 {method 'bit_length' of 'int' objects}
#1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
#182536    0.039    0.000    0.039    0.000 {method 'getrandbits' of '_random.Random' objects}
#1    0.001    0.001    0.001    0.001 {method 'index' of 'list' objects}

def third(SIZE):
    MIN_ITEM = -1008000
    MAX_ITEM = 3564098
    array = [random.randint(MIN_ITEM, MAX_ITEM) for _ in range(SIZE)]
    for i in range(len(array)):
        if array[i]>=0:
            array[i]=float('-inf')
    k = max(array)
    index = array.index(k)
    return k,index


cProfile.run('first(100000)')
cProfile.run('second(100000)')
cProfile.run('third(100000)')





