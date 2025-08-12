def generateInvariantAllRational(M,r):
    RJF = rationaljordanform(M)
    #print(RJF)
    i =0 
    Inv = []
    TSet = candidates(RJF)
    TSet = mergevectors(RJF[1],TSet)
    #print(TSet)
    while i < len(TSet):
        #print(i);
        #print(TSet[i])
        #print(checkInvariantRational(TSet[i],RJF[0],r)) 
        if checkInvariantRational(TSet[i],RJF[0],r) == 'TRUE':
            Inv.append(TSet[i])
        i = i+1
    return Inv
