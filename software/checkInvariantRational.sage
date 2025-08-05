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
    print(X)
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
    print(F)
    return qepcad(F)
