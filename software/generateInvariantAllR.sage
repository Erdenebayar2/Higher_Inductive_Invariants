def generateInvariantAll(M,r,m):
    if m ==0:
        char_poly = M.charpoly('x')
        mul = multiplicity(char_poly)
        i = 0
        #BadSet=[]
        #while i<len(mul):
            #BadSet.append(-1)
            #i = i+1
        #BadSet.append(0)
        i =0 
        Inv = []
        TSet = candidates(M)
        print(TSet)
        while i < len(TSet):
            #print(i);
            print(TSet[i])
            print(checkInvariant(TSet[i],M,r)) 
            if checkInvariant(TSet[i],M,r) == 'TRUE':
                Inv.append(TSet[i])
            i = i+1
    if m ==1:
        char_poly = M.charpoly('x')
        mul = multiplicity(char_poly)
        i = 0
        #BadSet=[]
        #while i<len(mul):
            #BadSet.append(-1)
            #i = i+1
        #BadSet.append(0)
        i =0 
        Inv = []
        TSet = candidates(M)
        print(TSet)
        while i < len(TSet):
            #print(i);
            print(TSet[i])
            print(checkInvariantRational(TSet[i],M,r)) 
            if checkInvariantRational(TSet[i],M,r) == 'TRUE':
                Inv.append(TSet[i])
            i = i+1
    #Inv.append(BadSet)
    return Inv
