def mergevectors(M,Inv):
    #print(Inv)
    SInv = []
    i =0
    mulnr = multiplicity(M.charpoly('x'))
    #print(mulnr)
    nnr = M.nrows()
    #print(nnr)
    while i< len(Inv):
        j=0
        Cvec = Inv[i][1]
        cnl = []
        while j< len(Inv[i][0])-1:
            cnl.append(Inv[i][0][j])
            j = j+1
        #print(cnl)
        CVecNR = convertmult(mulnr, cnl,nnr)
        Mid = Inv[i][0][j]
        CVecNR.append(Mid)
        #print(CVecNR)
        j=0
        #print(Inv)
        Cve = Cvec+CVecNR
        #print(Cve)
        i=i+1
        #print(Inv)
        SInv.append(Cve)
        #print(SInv)
    return SInv
