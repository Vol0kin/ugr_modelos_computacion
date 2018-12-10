lista1 = ['asds', 'prueba', 'F']
listacopia = lista1
for item in lista1:
    print(item)
for item in listacopia:
    print(item, end = ' ')
lista2 = [1, 1.1, -1, -1.1]
lista3 = lista1 + lista2
print(lista3)
for item in lista3:
    print(item, end = '_')
lista2.append(10)
print(lista2[4])
