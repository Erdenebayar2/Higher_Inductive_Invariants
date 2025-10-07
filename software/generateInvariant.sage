def generateInvariant(example,r):
    load(example)
    char_poly = M.charpoly('x')
    mul = multiplicity(char_poly)
    RJF = rationaljordanform(M)
    RatRoots = rationalmul(M)
    ratmul = RatRoots[0]
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
    i=0
    while i<len(Inv):
        #print(i)
        G = qf.or_(G,logicalformula(M, Inv[i], ratmul, irmul, n))
        i =i+1
    #print(Inv)
    #print ("J is a real Jordan form of the update map")
    print(InvIneq>0, 'is an ', r, 'th invariant inequality of a loop when', '(',a[1], ',...,', a[n+1],') satisfies the following logical formula' )
    #print(F)
    #G = qepcad(G)
    #print(qepcad(G))
    return G
    
def generateInvariantAll(M,r):
    RJF = rationaljordanform(M)
    #print(RJF)
    i =0 
    Inv = []
    TSet = candidates(RJF)
    #print(len(TSet))
    #print(TSet)
    while i < len(TSet):
        #print(i);
        #print(TSet[i])
        #print(checkInvariant(TSet[i],RJF,r)) 
        if checkInvariant(TSet[i],RJF,r) == 'TRUE':
            Inv.append(TSet[i])
        i = i+1
    return Inv
    
def generateInvariantAllRational(M,r):
    RJF = rationaljordanform(M)
    #print(RJF)
    i =0 
    Inv = []
    TSet = candidates(RJF)
    TSet = mergevectors(RJF[1],TSet)
    #print(len(TSet))
    while i < len(TSet):
        #print(i);
        #print(TSet[i])
        #print(checkInvariantRational(TSet[i],RJF[0],r)) 
        if checkInvariantRational(TSet[i],RJF[0],r) == 'TRUE':
            Inv.append(TSet[i])
        i = i+1
    return Inv


def generateInvariantMat(M,r):
    char_poly = M.charpoly('x')
    mul = multiplicity(char_poly)
    RJF = rationaljordanform(M)
    RatRoots = rationalmul(M)
    ratmul = RatRoots[0]
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
    i=0
    while i<len(Inv):
        #print(i)
        G = qf.or_(G,logicalformula(M, Inv[i], ratmul, irmul, n))
        i =i+1
    print(Inv)
    print ("J is a real Jordan form of the update map")
    print(InvIneq>0, 'is an ', r, 'th invariant inequality of a loop with the update map J when', '(',a[1], ',...,', a[n+1],') satisfies the following logical formula' )
    #print(F)
    #G = qepcad(G)
    print(qepcad(G))
    return G
    
def generateInvariantN(M,r):
    char_poly = M.charpoly('x')
    mul = multiplicity(char_poly)
    RJF = rationaljordanform(M)
    RatRoots = rationalmul(M)
    ratmul = RatRoots[0]
    #print('Ra')
    if r ==0:
        print("The number of rational eigenvalues is ", len(ratmul))
    #print(mul)
    #print(mul)
    #print(sum(mul))
    ### Case distinction: eigenvalues are 0.)non-real  1.) mixed  2.) all rational 
    if sum(mul)==0 :
        m = 1
    else:
        m=0
    #print(m)
    if sum(mul) == sum(ratmul) and sum(mul)>0:
        m=2
    #print(m)
    n = M.nrows()
    ### Generating when r=0 and mixed case
    if r==0 and m<1:
        Inv = generateInvariantAll(M,0)
        Extra = [1]
        #print(Inv)
        #Inv = mergevectors(RJF[1],Inv)
    ### Generating when r>1 and mixed case
    if r >0 and m<1:
        PreEx = generateInvariantN(M,r-1)
        Pre = PreEx[0]
        Extra = Pre[2]
        Inv = Pre
        #print(Pre)
        if Extra != []:
            i = 0
            TSet = candidates(RJF)
            #print('TSet')
            #print(TSet)
            while i< len(Pre):
                TSet.remove(Pre[i])
                i = i+1
            ### Checking the stabilization
            Extra = []
            i=0
            while i < len(TSet):
                #print(i);
                #print(TSet[i])
                #print(checkInvariant(TSet[i],RJF,r)) 
                if checkInvariant(TSet[i],RJF,r) == 'TRUE':
                    Inv.append(TSet[i])
                    Extra.append(TSet[i])
                    #print(Inv)
                i = i+1
            if Extra ==[]:
                print("The stabilizer index is ", r-1)
        ### No real eigenvalues
    if m ==1:
        Extra = []
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
        print("The stabilizer index is 0")
    if r==0 and m==2:
        Inv = generateInvariantAllRational(M,0)
        Extra = [1]
        #print(Inv)
    if r >0 and m==2:
        PreEx = generateInvariantN(M,r-1)
        Pre = PreEx[0]
        Inv = Pre
        #print(PreEx)
        #print('Pre')
        #print(Pre)
        Extra =PreEx[2]
        if Extra !=[]:
            i = 0
            TSet = candidates(RJF)
            TSet =mergevectors(RJF[1],TSet)
            #print('TSet')
            #print(Inv)
            while i< len(Pre):
                TSet.remove(Pre[i])
                i = i+1
            #print('Here')
            #print(TSet)
            Extra = []
            i=0
            while i < len(TSet):
                #print(i);
                #print(TSet[i])
                #print(checkInvariantRational(TSet[i],RJF[0],r)) 
                if checkInvariantRational(TSet[i],RJF[0],r) == 'TRUE':
                    Inv.append(TSet[i])
                    Extra.append(TSet[i])
                    #print(Inv)
                i = i+1
            if Extra ==[]:
                print("The stabilizer index is ", r-1)
            #print(Inv)
    return [Inv,m,Extra]
