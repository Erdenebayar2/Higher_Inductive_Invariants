def logicalformula(M,c, ratmul, irmul, n):
    a = [var(f'a{i}') for i in range(n+2)]
    qf = qepcad_formula
    Fi =[]
    A = []
    i =0
    while i<n+2:
        A.append(a[i])
        i = i+1
    #print(A)
    if sum(ratmul) == n:
        [J,P]=M.jordan_form(transformation=True,eigenvalues = rationalmul(M)[1])
        i =0
        P = block_diagonal_matrix(matrix(QQ,[1]), P)
        P = block_diagonal_matrix(P,matrix(QQ,[1]))
        #print(P)
        A = (matrix(SR, A)*P)[0]
    #print(A,P)
    #print(J)
    j=0
    while j<sum(ratmul)+sum(irmul):
        if j< sum(ratmul):
            k=0
            block =0
            while k<len(ratmul):
                i=0
                block =0
                while i<k+1:
                    block = block+ratmul[i]
                    i = i+1
                #print(block)
                if c[j]==0 and j<block:
                    Fi = qf.and_(Fi, A[j+1]==0)
                    j=j+1
                elif j>= block:
                    k = k+1
                else:
                    Fi = qf.and_(Fi, A[j+1]!=0) 
                    j = block
                    k = k+1
                #print(Fi)
                #print(j)
                #print(k)
        else:
            k=0
            while k<len(irmul):
                i=0
                block =0
                while i<k+1:
                    block = block+irmul[i]
                    i = i+1
                i = 0
                while i<len(ratmul):
                    block = block+ratmul[i]
                    i = i+1
                #print(block)
                if c[j]==0 and j<block:
                    Fi = qf.and_(Fi, A[j+1]==0)
                    j=j+1
                elif j>= block:
                    k = k+1
                else:
                    Fi = qf.and_(Fi, A[j+1]!=0)
                    j = block
                    k = k+1
                #print('irrational')
                #print(Fi)
                #print(j)
                #print(k)
        #print(Fi)
    ### Addcomplex
    i=0
    while i< len(c)-sum(ratmul)-sum(irmul)-1:
        Fi=qf.and_(Fi,A[sum(ratmul)+sum(irmul)+i+1]==0)
        i=i+1
    if c[n] ==1:
        Fi = qf.and_(Fi, A[n+1]>=0)
    else:
        Fi = qf.and_(Fi, A[n+1]<=0)
    return Fi
