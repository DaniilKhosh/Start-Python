s = str(input("Введите строку: "))

substroke = set()

for i in range(len(s)):
    if i == 0:
        for j in range(len(s)-1, i, -1):
            substroke.add(hash(s[i:j]))
            # print(s[i:j], i, j)
    else:
        for j in range(len(s), i, -1):
            substroke.add(hash(s[i:j]))
            # print(s[i:j], i, j)

print("Количество уникальных подстрок в строке:", len(substroke))

