def checkInvariant(c, M,r):
    n = M.nrows()
    char_poly = M.charpoly('x')
    mul = multiplicity(char_poly)
    var('alpha')
    mu = [var(f'mu{i}') for i in range(len(mul)+1)]
    lam = [var(f'lam{i}') for i in range(r+2)]
    var('y')
    f = lam[0]
    i = 1
    while i<r+1:
        f = f+lam[i]*y**i
        i = i+1
    f = f-alpha*y**(r+1)
    qf = qepcad_formula
    G = qf.or_(alpha==0, alpha==1)
    j=0
    while j<len(c)-1:
        i = 1
        if j == 0:
            F =qf.and_(char_poly.subs(x=mu[1])==0, (c[j]+1)*f.subs(y=mu[1]))
        if j > 0:
            F = qf.and_(F, char_poly.subs(x=mu[j+1])==0, (c[j]+1)*f.subs(y=mu[j+1])==0)
        #print(F)
        while i < c[j]+1:
            g = diff(f,y,i)
            #print(g)
            F = qf.and_(F, g.subs(y=mu[j+1])==0)
            i=i+1
        #print(F)
        j = j+1
    g = lam[0]-alpha
    #print(g)
    i =1
    while i< r+1:
        g = g+lam[i]
        i = i+1
        #print(g)
    g = g*c[len(c)-1]+lam[r+1]
    #print(g)
    F = qf.and_(F, g==0)
    i =0
    while i<r+2:
        F = qf.and_(F, lam[i]>=0)
        i = i+1
    i=1
    lamsum = lam[0]
    while i< r+2:
        lamsum = lamsum+lam[i]
        i=i+1
    i = 0
    F = qf.and_(F,lamsum>0)
    F = qf.and_(F,G)
    while i<len(mul)-1:
        i=i+1
        F = qf.and_(F, mu[i+1]-mu[i]>0)
        #print(F)
    i = 0
    while i < len(mul):
        F = qf.exists(mu[i+1],F)
        i = i+1
    i = 0
    while i < r+2:
        F = qf.exists(lam[i],F)
        i = i+1
    F = qf.exists(alpha, F)
    print(F)
    return qepcad(F)
