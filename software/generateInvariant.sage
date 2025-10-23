def generateInvariant(example, r, option):
    load(example)
    n = M.nrows()
    Cr = computeCr(example,r)
    phi = Cr[0]
    Stab = Cr[1]
    #print(n)
    x = [var(f'x{i}') for i in range(n+1)]
    a= [var(f'a{i}') for i in range(n+2)]
    qf = qepcad_formula
    F = phi
    #print(F)
    initialM = matrix(QQ, initial)
    i =0
    while i< Stab+1:
        N = M**i*(initialM.T)
        #print(N)
        j =0
        f=0
        while j<n:
           f= f+ a[j+1]*N[j,0]
           j=j+1
        F = qf.and_([F], f+a[n+1]>0)
        print(F)
        i=i+1
    if option == 'All':
        f = a[n+1]
        i =1
        while i<n+1:
            f=f+a[i]*x[i]
            i = i+1
        F = qf.and_(F, f<=0)
        F = qf.not_(F)
        i = 0
        while i<n+1:
            F =qf.forall(a[i+1],F)
            i = i+1
        #print(F)
        print("The smallest reachable set is defined by")
        F= qepcad(F)
        #print(F)
    if option == 'any':
        i=1
        InvIneq = 0
        while i< n+1:
            InvIneq = InvIneq+a[i]*x[i]
            i = i+1
        InvIneq = InvIneq+a[n+1]
        print(InvIneq>0, 'is an ', r, 'th invariant inequality of a loop with the update map J when' )
        print(F)
        F = qepcad(F,solution='any-point')
    if option == 'some':
        i=1
        InvIneq = 0
        while i< n+1:
            InvIneq = InvIneq+a[i]*x[i]
            i = i+1
        InvIneq = InvIneq+a[n+1]
        print(F)
        print(InvIneq>0, 'is an ', r, 'th invariant inequality of a loop with the update map J when' )
        F = qepcad(F,solution='cell-points')
    #print(F)
    return F
