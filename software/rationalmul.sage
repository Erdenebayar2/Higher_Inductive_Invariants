def rationalmul(M):
    n = M.nrows()
    char_poly = M.charpoly('x')
    F = char_poly.factor()
    ratmul = []
    i =0
    while i<len(F):
        #print('Rationalmul')
        #print(F[i][0])
        if F[i][0].degree() ==1:
            ratmul.append(F[i][1])
            #print(ratmul)
        i = i+1
    return ratmul
