def LinearInductiveInvariantsFixedOrder(example, k):
    load(example)
    R.<t> = QQ[]
    S.<u> = PolynomialRing(R)
    Ru.<uR> = PolynomialRing(QQ)
    Rt.<tR> = PolynomialRing(Ru)
    a=vector(QQ,initial)
    q = M.minpoly('t')
    G = divisors_polynomial(q)

    n = M.nrows()

    #---------------------------------------------------------
    # Variables c0,...,c_{n-1}, b
    #---------------------------------------------------------
    c = vector(SR, [var(f'c{i}') for i in range(1, n+2)])
    cc = vector(SR, list(c[:-1])) 
    b = var('b')

    qf = qepcad_formula

    Psi_out = None

    #---------------------------------------------------------
    # Loop over all divisors
    #---------------------------------------------------------
    for g in G:

        s = InductiveTest(g, k)

        # UNSAT
        if s == -2:
            continue

        #---------------------------------------------------------
        # Compute W_g
        #---------------------------------------------------------
        Kg = g(M).transpose().right_kernel()
        #print(Kg)
        Wg = Kg.basis_matrix().right_kernel().basis_matrix()

        #Wg---------------------------------------------------------
        # Construct Lambda_g
        #---------------------------------------------------------
        Lambda = None
        # W_g c = 0
        if len(Wg.rows())==0:
            if Lambda is None:
                Lambda=(c[0]==c[0])
            else:
                Lambda = qf.and_(Lambda, (c[0]==c[0]))
        else:
            for row in Wg.rows():

                eq = (row.dot_product(cc) == 0)

                if Lambda is None:
                    Lambda = eq
                else:
                    Lambda = qf.and_(Lambda, eq)

        #---------------------------------------------------------
        # S_g(b)
        #---------------------------------------------------------
        if s == 1:

            if Lambda is None:
                Lambda = (c[-1] >= 0)
            else:
                Lambda = qf.and_(Lambda, c[-1] >= 0)

        elif s == -1:

            if Lambda is None:
                Lambda = (c[-1] <= 0)
            else:
                Lambda = qf.and_(Lambda, c[-1] <= 0)
        elif s ==2:
            if Lambda is None:
                Lambda = (c[-1] > 0)
            else:
                Lambda = qf.and_(Lambda, c[-1] > 0)
        # s == 0 : add nothing

        #---------------------------------------------------------
        # c^T M^i a + b > 0
        #---------------------------------------------------------
        #for i in range(k+1):

            #cond = (cc.dot_product((M^i)*a) + c[-1] > 0)

            #if Lambda is None:
                #Lambda = cond
            #else:
                #Lambda = qf.and_(Lambda, cond)

        #---------------------------------------------------------
        # Psi_out = Psi_out OR Lambda
        #---------------------------------------------------------
        if Psi_out is None:
            Psi_out = Lambda
        else:
            Psi_out = qf.or_(Psi_out, Lambda)
    #for i in range(k+1):
        #cond = (cc.dot_product((M^i)*a) + c[-1] > 0)
        #if Psi_out is None:
            #Psi_out = cond
        #else:
            #Psi_out =qf.and_(Psi_out,cond)
    return Psi_out

def divisors_polynomial(f):

    fac = f.factor()

    factors = [g for g, e in fac]
    exponents = [e for g, e in fac]

    divisors = []

    for powers in product(*[range(e+1) for e in exponents]):

        d = f.parent()(1)

        for g, p in zip(factors, powers):
            d *= g^p

        divisors.append(d)

    return divisors
