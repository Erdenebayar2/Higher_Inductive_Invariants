def LinearHigherInductiveInvariants(example):
    load(example)
    R.<t> = QQ[]
    S.<u> = PolynomialRing(R)
    Ru.<uR> = PolynomialRing(QQ)
    Rt.<tR> = PolynomialRing(Ru)
    a=vector(QQ,initial)
    q = M.minpoly('t')
    G = divisors_polynomial(q)
    print(G)
    #Collect weak perron polynomials from G
    G0 = []
    for g in G:
        if SelectDivisors(g):
            G0.append(g)
    #Find the condition on a constant coefficient for each weak Perro divisor of q 
    InvCon = []
    for g in G0:
        InvCon.append([ConstantTest(g),g])
    k=0
    print(G0)
    for cond in InvCon:
        #print(cond)
        while InductiveTest(cond[1],k) != cond[0]:
            k = k+1
    return [LinearInductiveInvariantsFixedOrder(example, k),k]
