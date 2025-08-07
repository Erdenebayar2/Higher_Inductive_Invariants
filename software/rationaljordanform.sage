def rationaljordanform(M):
    n = M.nrows()
    char_poly = M.charpoly('x')
    F = char_poly.factor()
    #print(F)
    roots = []
    i =0
    while i<len(F):
        if F[i][0].degree() ==1:
            roots.append(-(F[i][0].coefficients(sparse=False))[0])
        i=i+1
    roots.sort()
    i =0 
    JR = matrix(QQ,[])
    while i < len(roots):
        j = 0
        while j < len(F):
            if F[j][0].degree() ==1 and -(F[j][0].coefficients(sparse=False))[0] == roots[i]:
                JR = block_diagonal_matrix(JR, jordan_block(roots[i], F[j][1]))
            j = j+1               
        i= i+1
    #print(JR)
    i =0
    while i<len(F):
        JC = matrix(QQ,[])
        if F[i][0].degree()>1:
            JC = companion_matrix(F[i][0].coefficients(sparse=False))
            j =1
            while j< F[i][1]:
                if j ==1:
                    JC = block_matrix([[JC,identity_matrix(QQ,len(F[i][0].coefficients(sparse=False))-1)]])
                else:
                    JC = block_matrix([[JC,zero_matrix(QQ,len(F[i][0].coefficients(sparse=False))-1)]])
                j = j+1
            #print(JC)
            j =1
            while j<F[i][1]:
                JCC = zero_matrix(QQ, len(F[i][0].coefficients(sparse=False))-1)
                #print(JCC)
                k = 1
                while k<j:
                    JCC = block_matrix([[JCC, zero_matrix(QQ, len(F[i][0].coefficients(sparse=False))-1)]])
                    k = k+1
                    #print(JCC)
                JCC = block_matrix([[JCC,companion_matrix(F[i][0].coefficients(sparse=False))]])
                if k+1<F[i][1]:
                    JCC =block_matrix([[JCC,identity_matrix(QQ,len(F[i][0].coefficients(sparse=False))-1)]])
                    #print(JCC)
                    while k+2<F[i][1]:
                        JCC = block_matrix([[JCC,zero_matrix(QQ, len(F[i][0].coefficients(sparse=False))-1)]])
                        k = k+1
                    #print(JCC)
                JC = block_matrix([[JC],[JCC]])
                #print(JC)
                j=j+1
        i = i+1
    #print(JC)
    return [JR,JC]
