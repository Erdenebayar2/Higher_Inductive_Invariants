def checkInvariant(c, M,r):
    MR = M[0]
    MNR = M[1]
    cr = c[1]
    cnr= c[0]
    ### Non rational case
    n = MNR.nrows()
    char_poly = MNR.charpoly('x')
    mulnr = multiplicity(char_poly)
    var('alpha')
    mu = [var(f'mu{i}') for i in range(len(mulnr)+1)]
    lam = [var(f'lam{i}') for i in range(r+2)]
    var('y')
    f = lam[0]
    i = 1
    while i<r+1:
        f = f+lam[i]*y**i
        i = i+1
    f = f-alpha*y**(r+1)
    qf = qepcad_formula
    if sum(mulnr) ==0:
        F = qf.or_(lam[0]<=0,lam[1]>0)
    G = qf.or_(alpha==0, alpha==1)
    j=0
    while j<len(cnr)-1:
        i = 1
        if j == 0:
            F =qf.and_(char_poly.subs(x=mu[1])==0, (cnr[j]+1)*f.subs(y=mu[1]))
        if j > 0:
            F = qf.and_(F, char_poly.subs(x=mu[j+1])==0, (cnr[j]+1)*f.subs(y=mu[j+1])==0)
        #print(F)
        while i < cnr[j]+1:
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
    g = g*cnr[len(cnr)-1]+lam[r+1]
    #print(g)
    F = qf.and_(F, g==0)
    #print(F)
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
    while i<len(mulnr)-1:
        i=i+1
        F = qf.and_(F, mu[i+1]-mu[i]>0)
    #print(F)
    ###Rational case
    nr = MR.nrows()
    char_poly = MR.charpoly('x')
    mul = multiplicity(char_poly)
    if sum(mul) > 0:
        cr = matrix(QQ, cr)
        #print(cr)
        #print(MR)
        LiEq =lam[0]*cr
        #print(LiEq)
        i =1;
        while i< r+1:
            LiEq =LiEq+lam[i]*cr*MR**i
            i =i+1
            #print(LiEq)
        LiEq = LiEq-alpha*cr*MR**(r+1)
        #print(LiEq)
        i=0
        while i<nr:
            F = qf.and_(F, LiEq[0,i]==0)
            i=i+1 
    F = qf.and_(F,G)
### Quantifiers
    i = 0
    while i < len(mulnr):
        F = qf.exists(mu[i+1],F)
        i = i+1
    i = 0
    while i < r+2:
        F = qf.exists(lam[i],F)
        i = i+1
    F = qf.exists(alpha, F)
    #print(F)
    return qepcad(F)
    
    
def checkInvariantRational(c, M,r):
    n = M.nrows()
    char_poly = M.charpoly('x')
    mul = multiplicity(char_poly)
    px = [var(f'px{i}') for i in range(n+1)]
    X = [px[1]];
    i = 1;
    while i < n:
        X.append(px[i+1])
        i = i+1
    #print(X)
    #print(c)
    cn = [c[0]]
    i = 1;
    while i <len(c)-1:
        cn.append(c[i])
        i = i+1
    cn = matrix(QQ, cn)
    #print(cn)
    qf = qepcad_formula
    #print(X)
    F = qf.or_(multMatrices(X,M,cn,0)+c[len(c)-1]<=0, multMatrices(X,M,cn,r+1)+c[len(c)-1]>0)
    i = 0 
    while i< r:
        F= qf.or_(F, multMatrices(X,M,cn,i+1)+c[len(c)-1]<=0)
        i = i+1
    G =qf.or_(px[1]>=0, px[1]<0)
    i = 1
    while i < n:
        i = i+1
        GP = qf.or_(px[i]>=0, px[i]<0)
        G = qf.and_(G,GP)
    F = qf.and_(F,G)
    #print(F)
    i =0 
    while i < n:
        F = qf.forall(px[i+1],F);
        i=i+1
    #print(F)
    #print(F)
    return qepcad(F)
