def multiplicity(f): 
    complexroots = complex_roots(f)
    #print(complexroots)
    length = len(complexroots)
    multip=[]
    i=0
    while i < length :
        if (complexroots[i][0]).n() in RR:
            multip.append(complexroots[i][1])
        i = i+1
    return multip
    
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
    if sum(ratmul)==n:
        [J,P]=M.jordan_form(transformation=True,eigenvalues = RatRootsMS)
        #print(J)
        ratmul =[]
        i=0
        while i <n-1:
            if J[i][i+1]==0 and ratmul==[]:
                #print(i)
                ratmul.append(i+1)
                #print("first")
                #print(ratmul)
            elif J[i][i+1]==0 and ratmul!=[]:
                ratmul.append(i+1-sum(ratmul))
            #print(ratmul)
            i = i+1
        if sum(ratmul) !=n:
            ratmul.append(n-sum(ratmul))
    return [ratmul, RatRootsMS]
