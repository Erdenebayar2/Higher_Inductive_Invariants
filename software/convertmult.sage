def convertmult(mul,c,n):
    C = [var(f'C{i}') for i in range(len(c))]
    #=cn = [c[0]]
    #i = 1;
    #while i <len(c)-1:
        #cn.append(c[i]+1)
        #i = i+1
    i = 0
    while i < len(mul):
        C[i]=[]
        j =0
        while j<mul[i]:
            if j == mul[i] - c[i]-1:
                C[i].append(1)
            if j != mul[i]-c[i]-1:
                C[i].append(0)
            #print(C[i])
            j = j+1
        i = i+1
    CSet = []
    i =0;
    while i<len(mul):
        CSet = CSet +C[i]
        i=i+1
    #CSet.append(c[len(c)-1])
    return CSet
