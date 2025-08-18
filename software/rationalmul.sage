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
    RatRootsM = char_poly.roots(ring = QQ, multiplicities =True)
    RatRoots = []
    i =0 
    while i<len(RatRootsM):
        RatRoots.append(RatRootsM[i][0])
        i = i+1
    RatRoots.sort()
    RatRootsMS = []
    i = 0
    while i< len(RatRoots):
        j =0
        while j<len(RatRootsM):
            if RatRootsM[j][0] == RatRoots[i]:
                RatRootsMS.append(RatRootsM[j])
            j = j+1
        i = i+1
    return [ratmul, RatRootsMS]
