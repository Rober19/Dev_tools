def bouncy(n):
    str_n = str(n)
    sorted_str = ''.join(sorted(list(str_n)))
    return not(str_n == sorted_str or str_n == sorted_str[::-1])

#Rober19
# porcentaje | num. min --> 50 = 538 | 90 = 21780 | 99 = ?
# Encuentre el numero minimo para el cual la proporcion de numeros bouncy es exactamente el 99%

#porcent_n = 0.50 # numero minimo = 538
#porcent_n = 0.90 # numero minimo = 21780
porcent_n = 90 # numero minimo = 1587000

numBouncy = 0
numNotBouncy = 99 # all 2 digit numbers are not bouncy
i = 99
while float(numBouncy)/(numNotBouncy + numBouncy) < (porcent_n*0.01):
    i += 1
    if bouncy(i):
        numBouncy += 1
    else:
        numNotBouncy += 1


print "El numero minimo para el cual la proporcion\nde numeros bouncy es exactamente el %d%% es %d" % (int(porcent_n),i)