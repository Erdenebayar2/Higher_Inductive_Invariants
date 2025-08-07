def generateInvariant(M,r):
    char_poly = M.charpoly('x')
    mul = multiplicity(char_poly)
    RJF = rationaljordanform(M)
    #ratmul = rationalmul(M)
    #print('Ra')
    #print(ratmul)
    #print(mul)
    print(mul)
    if sum(mul)==0 :
        m = 1
    else:
        m=0
    print(m)
    n = M.nrows()
    if r==0 and m<1:
        Inv = generateInvariantAll(M,0)
        print(Inv)
        Inv = mergevectors(RJF[1],Inv)
    if r >0 and m<1:
        Pre = generateInvariantAll(M,r-1)
        Inv = Pre
        print(Pre)
        i = 0
        TSet = candidates(RJF)
        print('TSet')
        print(TSet)
        while i< len(Pre):
            TSet.remove(Pre[i])
            i = i+1
        print('Here')
        print(TSet)
        i=0
        
        while i < len(TSet):
            #print(i);
            print(TSet[i])
            print(checkInvariant(TSet[i],RJF,r)) 
            if checkInvariant(TSet[i],RJF,r) == 'TRUE':
                Inv.append(TSet[i])
            i = i+1
        print(Inv)
        Inv = mergevectors(RJF[1],Inv)
        ### Add zeros corresponding to complex eigenvalues
    
    #if m==0:
        #print(Inv)
        #Inva=[]
        #i =0
        #while i< len(Inv):
            #j=0
            #m =[]
            #while j<len(mul):
                #m.append(mul[len(mul)-1-j])
                #j=j+1
            #print(m)
            #Inva.append(convertmult(mul,Inv[i],n))
            #i=i+1
        #i=0
        #Inv =[]
        #print(Inva)
        #while i < len(Inva):
            #Addcomplex=[]
            #j=0
            #while j< len(Inva[i])-1:
                #Addcomplex.append(Inva[i][j])
                #j=j+1
            #print(Addcomplex)
            #j=0
            #while j< n +1- len(Inva[i]):
                #j=j+1
                #Addcomplex.append(0)
            #print(Addcomplex)
            #Addcomplex.append(Inva[i][len(Inva[i])-1])
            #Inv.append(Addcomplex)
            #print(Inv)
            #i=i+1
        ### No real eigenvalues
    if m ==1:
        InvCom =[]
        InvComM =[]
        i = 0
        while i< M.nrows():
            InvCom.append(0)
            InvComM.append(0)
            i = i+1
        InvComM.append(-1)
        InvCom.append(1)
        #print(InvCom)
        #print(InvComM)
        Inv = [InvComM, InvCom]
    return Inv
