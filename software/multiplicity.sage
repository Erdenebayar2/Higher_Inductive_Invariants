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
