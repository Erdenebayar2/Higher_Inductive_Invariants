def quantifierElimination(example,r):
    load(example)
    n = M.nrows()
    #print(n)
    x = [var(f'x{i}') for i in range(n+1)]
    c= [var(f'c{i}') for i in range(n+2)]
    qf = qepcad_formula
    Vars = [x[1]]
    #print(Vars)
    i =1
    while i<n:
        i = i+1
        Vars.append(x[i])
        #print(Vars)
    Vars = matrix(SR, [Vars])
    #print(Vars)
    formula1 = c[n+1]
    formula2 = c[n+1]
    N = M**(r+1)*(Vars.T)
    #print(N)
    i =0
    while i<n:
        i = i+1
        formula1 =formula1+c[i]*x[i]
        formula2 =formula2+c[i]*N[i-1,0]
    F = qf.or_(formula1<=0, formula2>0)
    i =1
    while i<r+1:
        formula1 = c[n+1]
        N = M**i*(Vars.T)
        j=0
        while j<n:
            j = j+1
            formula1 =formula1+c[j]*N[j-1,0]
        i = i+1
        F = qf.or_(F, formula1<=0)
    i =0
    while i<n:
        F =qf.forall(x[i+1],F)
        i = i+1
    QE = qepcad(F, interact =True)
    QE.go()
    result = QE.finish()
    print(result)
    return result
        
        
        
def quantifierEliminationOld(example,r):
    load(example)
    n = M.nrows()
    F = quantifierElimination(example,0)
    k = 0
    StabIn = 0
    while k< r and StabIn==0:
        k = k+1
        FF= quantifierEliminationOld(example,k)
        if F ==FF:
            StabIn =1
            print(F)
            return F
        F = FF
    if StabIn ==0:
        print(F)
        return F
