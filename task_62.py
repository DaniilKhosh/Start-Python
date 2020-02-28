# Пользователь вводит данные о количестве предприятий,
# их наименования и прибыль за квартал для каждого.
# Программа должна определить среднюю прибыль и
# вывести наименования предприятий, чья прибыль выше среднего.
# Отдельно вывести наименования предприятий, чья прибыль ниже среднего.
import sys
from collections import namedtuple, deque

QUARTERS = 4
Company = namedtuple('Company', ['name', 'quarters', 'profit'])
all_companies = set()

num = int(input("Введите количество предприятий: "))
total_profit = 0
r = 0
for i in range(1, num + 1):
    profit = 0
    quarters = []
    name = input(f'Введите название предприятия {i}: ')
    h = 0
    for j in range(QUARTERS):
        quarters.append(int(input(f'Прибыль за {j + 1}-й квартал: ')))
        profit += quarters[j]
        h += sys.getsizeof(quarters[j])
    comp = Company(name=name, quarters=tuple(quarters), profit=profit)
    # определим размер памяти, выделяемой для экземпляра класса и элементов в нем
    r += (sys.getsizeof(comp)+sys.getsizeof(comp.name) + sys.getsizeof(comp.profit) + sys.getsizeof(quarters) + h)


    all_companies.add(comp)
    total_profit += profit

average = total_profit / num

print(f'\nСредняя прибыль = {average}')



# вариант 1
print(f'\nПредприятя с прибылью выше среднего:')
for comp in all_companies:
    if comp.profit > average:
        print(f'Компания {comp.name} заработала {comp.profit}')
        # print(comp.quarters[0])   # так можно получить доступ к нужной четверти.

print(f'\nПредприятя с прибылью ниже среднего:')
for comp in all_companies:
    if comp.profit < average:
        print(f'Компания {comp.name} заработала {comp.profit}')

print(f"\nSize of QUARTERS is {sys.getsizeof(QUARTERS)}")
print(f"Size of Company is {sys.getsizeof(Company)}")
print(f"Size of all_companies is {sys.getsizeof(all_companies)}")
print(f"Size of num is {sys.getsizeof(num)}")
print(f"Size of total_profit is {sys.getsizeof(total_profit)}")
print(f"Size of i is {sys.getsizeof(i)}")
print(f"Size of profit is {sys.getsizeof(profit)}")
print(f"Size of quarters is {sys.getsizeof(quarters)}")
print(f"Size of average is {sys.getsizeof(average)}")
print(f"Common size is  {sys.getsizeof(average) + sys.getsizeof(quarters)+ sys.getsizeof(profit)+sys.getsizeof(i)+sys.getsizeof(total_profit)+sys.getsizeof(num)+sys.getsizeof(all_companies)+sys.getsizeof(Company)+sys.getsizeof(QUARTERS)+r}")

