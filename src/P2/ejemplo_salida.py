lista1 = ['esto', 'es', 'la', 'primera', 'lista']
lista2 = []
lista2 = lista1
print(lista1)
for item in lista1:
    print(item)
for item in lista2:
    print(item, end = '_')
comparacion = lista1 == lista2
print(comparacion)
lista3 = [1, 2, 3, 4]
lista4 = [4, 3, 2, 1]
lista_larga = lista3 + lista4
lista_larga.sort(reverse=True)
for item in lista_larga:
    print(item, end = '\n')
comparacion = lista3 < lista4
print(comparacion)
comparacion = lista3 != lista4
print(comparacion)
comparacion = lista3 == lista4.sort()
print(comparacion)
len(lista_larga)
lista5 = [5, 6]
comparacion = lista3 + lista5 == lista4 + lista5 + lista_larga
print(comparacion)
comparacion = len(lista1) == len(lista2)
print(comparacion)
comparacion = lista1[0] != lista2[2]
print(comparacion)
print(lista_larga[-1])
lista_nueva = []
lista_nueva.append(1.1)
lista_nueva.append(-123.45)
lista_nueva.append(15)
print(lista_nueva)
lista_nueva.remove(15)
print(lista_nueva)
