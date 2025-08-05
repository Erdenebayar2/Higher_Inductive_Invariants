def candidates(M,m):
    n = M.nrows()
    char_poly = M.charpoly('x')
    mul = multiplicity(char_poly)
    #print(mul)
    T = [var(f'T{i}') for i in range(len(mul)+1)]
    T[1]=[-1]
    i = 1
    while i < len(mul)+1:
        T[i]=[-1]
        #print(S[i])
        j =0
        while j< mul[i-1]:
            T[i].append(j)
            j = j+1
            #print(S[i])
        #print(S[i])
        i = i+1
    i=1
    while i < len(mul)+1:
        if i ==1:
            TSet = [T[1]]
        if i>1:
            TSet.append(T[i])
        i=i+1
    TSet.append([-1,1])
    TSet = CartesianProduct_iters(*TSet).list()
    if m ==1:
        Candidate = []
        i =0
        while i < len(TSet):
            Addcomplex=[]
            j=0
            Nocomplex =convertmult(mul,TSet[i],n)
            while j< len(Nocomplex)-1:
                Addcomplex.append(Nocomplex[j])
                j=j+1
            j=0
            while j< n+1- len(Nocomplex):
                Addcomplex.append(0)
                j=j+1
            Addcomplex.append(Nocomplex[len(Nocomplex)-1])
            Candidate.append(Addcomplex)
            i=i+1
        TSet=Candidate
    return TSet
