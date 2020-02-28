import math
import cProfile

def simple(n):
    lst = []
    k = 0
    for i in range(2, n+1):
       for j in range(2, i):
         if i % j == 0:
                k = k + 1
       if k == 0:
            lst.append(i)
       else:
          k = 0
    return lst



def speed(n):
    import math
    lst1=[]
    for i in range(2, n+1):
        for j in lst1:
            if j > int((math.sqrt(i)) + 1):
                lst1.append(i)
                break
            if (i % j == 0):
                break
        else:
            lst1.append(i)
    return lst1

cProfile.run('speed(10000)')
cProfile.run('simple(10000)')

#-----------------------------------------------
#Сравнение ниже показывает что алгоритм с применением теории чисел (когда перебираютя
# числа, не превосходящие корня из искомого) значительно быстрее обычного алгоритма
# Сложность алгоритма Эратосфена оценивается примерно как O(N*lnN)
# алгоритма с применением теории чисел возможно как O(SQRT(N)*lnN)
#

#"Task_42.simple(3000)"
#10 loops, best of 5: 630 msec per loop
#"Task_42.simple(2000)"
#10 loops, best of 5: 271 msec per loop
#"Task_42.simple(1000)"
#10 loops, best of 5: 60.5 msec per loop
#"Task_42.simple(500)"
#10 loops, best of 5: 12.9 msec per loop
#"Task_42.simple(250)"
#10 loops, best of 5: 2.96 msec per loop


#"Task_42.speed(3000)"
#10 loops, best of 5: 9.7 msec per loop
#"Task_42.speed(2000)"
#10 loops, best of 5: 6.09 msec per loop
#"Task_42.speed(1000)"
#10 loops, best of 5: 2.79 msec per loop
#"Task_42.speed(500)"
#10 loops, best of 5: 1.25 msec per loop
#"Task_42.speed(250)"
#10 loops, best of 5: 564 usec per loop

#ncalls  tottime  percall  cumtime  percall filename:lineno(function)
#1    0.000    0.000    7.599    7.599 <string>:1(<module>)
#1    7.599    7.599    7.599    7.599 Task_42.py:4(simple)
#1    0.000    0.000    7.599    7.599 {built-in method builtins.exec}
#1229    0.000    0.000    0.000    0.000 {method 'append' of 'list' objects}
#1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}

#ncalls  tottime  percall  cumtime  percall filename:lineno(function)
#1    0.000    0.000    0.051    0.051 <string>:1(<module>)
#1    0.040    0.040    0.051    0.051 Task_42.py:19(speed)
#1    0.000    0.000    0.051    0.051 {built-in method builtins.exec}
#45248    0.010    0.000    0.010    0.000 {built-in method math.sqrt}
#1229    0.000    0.000    0.000    0.000 {method 'append' of 'list' objects}
#1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}