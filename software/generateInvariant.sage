def generateInvariant(M,r):
    char_poly = M.charpoly('x')
    mul = multiplicity(char_poly)
    RJF = rationaljordanform(M)
    ratmul = rationalmul(M)
    irmul = multiplicity(RJF[1].charpoly('x'))
    n = M.nrows()
    a = [var(f'a{i}') for i in range(n+2)]
    x = [var(f'x{i}') for i in range(n+1)]
    i=1
    InvIneq = 0
    while i< n+1:
        InvIneq = InvIneq+a[i]*x[i]
        i = i+1
    InvIneq = InvIneq+a[n+1]
    Invm = generateInvariantN(M,r)
    Inv = Invm[0]
    m = Invm[1]
    if m == 0:
        Inv = mergevectors(RJF[1],Inv)
    ### Add zeros corresponding to complex eigenvalues
    Inva=[]
    i =0
    while i< len(Inv):
        j=0
        Inva.append(Inv[i])
        i=i+1
    i=0
    Inv =[]
    #print(Inva)
    while i < len(Inva):
        Addcomplex=[]
        j=0
        while j< len(Inva[i])-1:
            Addcomplex.append(Inva[i][j])
            j=j+1
        j=0
        while j< n +1- len(Inva[i]):
            j=j+1
            Addcomplex.append(0)
        #print(Addcomplex)
        Addcomplex.append(Inva[i][len(Inva[i])-1])
        Inv.append(Addcomplex)
        i=i+1
    qf = qepcad_formula
    F = []
    i =0
    while i< len(Inv):
        Fi =[]
        j=0
        while j<len(Inv[i])-1:
            if Inv[i][j]==0:
                Fi = qf.and_(Fi, a[j+1]==0)
            if Inv[i][j]== 1:
                Fi = qf.and_(Fi, a[j+1]!=0)
            j=j+1
        if Inv[i][j] ==1:
            Fi = qf.and_(Fi, a[j+1]>=0)
        else:
            Fi = qf.and_(Fi, a[j+1]<=0)
        F = qf.or_(F, Fi)
        i = i+1
    #print('Done')
    #print(Inv)
    G = []
    #print(ratmul)
    #print(irmul)
    #print(n)
    i =0
    while i<len(Inv):
        #print(i)
        G = qf.or_(G,logicalformula(Inv[i], ratmul, irmul, n))
        i =i+1
    print(Inv)
    print ("J is a real Jordan form of the update map")
    print(InvIneq>0, 'is an ', r, 'th invariant inequality of a loop with the update map J when', '(',a[1], ',...,', a[n+1],') satisfies the following logical formula' )
    #print(F)
    print(G)
    
   
