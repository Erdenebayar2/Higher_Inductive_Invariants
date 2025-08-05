def multMatrices(X,M,c,r):
    n = M.nrows()
    M = c*M**r
    #print(M)
    i = 0
    f = 0
    while i < n:
        #print(i)
        #print(X[i])
        #print(M[0,i])
        f = f+X[i]*M[0,i]
        #print(f)
        i = i +1
    return f
