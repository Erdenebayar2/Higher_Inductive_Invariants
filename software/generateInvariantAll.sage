def generateInvariantAll(M,r):
    RJF = rationaljordanform(M)
    #print(RJF)
    i =0 
    Inv = []
    TSet = candidates(RJF)
    #print(TSet)
    while i < len(TSet):
        #print(i);
        #print(TSet[i])
        #print(checkInvariant(TSet[i],RJF,r)) 
        if checkInvariant(TSet[i],RJF,r) == 'TRUE':
            Inv.append(TSet[i])
        i = i+1
    return Inv
