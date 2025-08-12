def candidates(M):
    MR = M[0]
    MNR = M[1]
    #print([MR,MNR])
    nnr = MNR.nrows()
    #print(nnr)
    char_poly = MNR.charpoly('x')
    mul = multiplicity(char_poly)
    #print('Mul')
    #print(mul)
    T = [var(f'T{i}') for i in range(len(mul)+1)]
    if len(mul) >0:
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
    #print(T)
    TSet =[]
    i=1
    while i < len(mul)+1:
        #print(T[1])
        if i ==1:
            TSet.append(T[1])
        if i>1:
            TSet.append(T[i])
        i=i+1
    #print(TSet)
    TSet.append([-1,1])
    TSet = CartesianProduct_iters(*TSet).list()
    #print(TSet)
    ### Rational case
    nr = MR.nrows()
    char_poly = MR.charpoly('x')
    mulr = multiplicity(char_poly)
    #print(mulr)
    S = [var(f'S{i}') for i in range(len(mulr)+1)]
    if len(mulr)>0:
        S[1]=[-1]
    else:
        SSet = []
    i = 1
    while i < len(mulr)+1:
        S[i]=[-1]
        #print(S[i])
        j =0
        while j< mulr[i-1]:
            S[i].append(j)
            j = j+1
            #print(S[i])
        #print(S[i])
        i = i+1
    #print(S)
    i=1
    while i < len(mulr)+1:
        if i ==1:
            SSet = [S[1]]
        if i>1:
            SSet.append(S[i])
        i=i+1
    SSet = CartesianProduct_iters(*SSet).list()
    RSet = []
    i =0 
    while i< len(SSet):
     RSet.append(convertmult(mulr, SSet[i],nr))
     i=i+1
    #print(RSet)
    #Candidate = []
    #i =0
    #while i < len(SSet):
        #Addcomplex=[]
        #j=0
        #Nocomplex =convertmult(mul,SSet[i],nr)
        #while j< len(Nocomplex)-1:
            #Addcomplex.append(Nocomplex[j])
            #j=j+1
        #j=0
        #while j< nr+1- len(Nocomplex):
            #Addcomplex.append(0)
            #j=j+1
        #Addcomplex.append(Nocomplex[len(Nocomplex)-1])
        #Candidate.append(Addcomplex)
        #i=i+1
        #SSet=Candidate
    return CartesianProduct_iters(*[TSet,RSet]).list()
