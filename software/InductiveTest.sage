def polynomial_to_lp(c, k, x):

    expr = 0

    # Is the polynomial ring univariate?
    univariate = c.parent().ngens() == 1

    for mon, coeff in c.dict().items():

        if univariate:
            exponents = (mon,)
        else:
            exponents = tuple(mon)

        # constant term
        if all(e == 0 for e in exponents):
            expr += coeff
            continue

        nz = [i for i,e in enumerate(exponents) if e != 0]

        if len(nz) != 1:
            raise ValueError("Polynomial is not linear.")

        j = nz[0]

        if not univariate:
            # last variable is t
            if j == k+1:
                raise ValueError("Coefficient still contains t.")

        if exponents[j] != 1:
            raise ValueError("Polynomial is not linear.")

        expr += coeff * x[j]

    return expr

from sage.numerical.mip import MixedIntegerLinearProgram, MIPSolverException

def SAT(equalities, extra_constraint, k):

    p = MixedIntegerLinearProgram(maximization=False)
    x = p.new_variable(real=True)

    # λ_i ≥ 0
    for i in range(k+1):
        p.add_constraint(x[i] >= 0)

    # Equalities
    for c in equalities:

        expr = polynomial_to_lp(c, k, x)

        #----------------------------------------
        # Constant polynomial
        #----------------------------------------
        if isinstance(expr, (int, Integer, Rational)):

            if expr != 0:
                return False, None      # inconsistent system

            continue                    # 0 = 0, ignore

        #----------------------------------------
        # Nonconstant expression
        #----------------------------------------
        p.add_constraint(expr == 0)

    # Extra constraint
    if extra_constraint is not None:
        extra_constraint(p, x)

    p.set_objective(0)

    try:
        p.solve()
        return True, p.get_values(x)

    except MIPSolverException:
        return False, None

def InductiveTest(g, k):

    #-------------------------------------------------------
    # Polynomial ring
    #-------------------------------------------------------
    names = [f"l{i}" for i in range(k+1)] + ["t"]

    R = PolynomialRing(QQ, names)

    gens = R.gens()

    lambdas = list(gens[:-1])

    t = gens[-1]

    #-------------------------------------------------------
    # P
    #-------------------------------------------------------
    P = t^(k+1)

    for i in range(k+1):
        P -= lambdas[i]*t^i
    #print(P)
    rem = P % R(g)
    #print(rem)
    coeffs = rem.polynomial(t).coefficients(sparse=False)
    #print(coeffs)
    #-------------------------------------------------------
    # First feasibility check
    #-------------------------------------------------------
    sat, sol = SAT(coeffs, None, k)

    if not sat:
        return -2
    #-------------------------------------------------------
    # Pseudocode
    #
    # 1-sum λ =0
    #-------------------------------------------------------
    sat_eq, _ = SAT(
        coeffs,
        lambda p,x: p.add_constraint(sum(x[i] for i in range(k+1)) == 1),
        k)

    if sat_eq:
        s = 0

    else:

        sat_gt, _ = SAT(
            coeffs,
            lambda p,x: p.add_constraint(sum(x[i] for i in range(k+1)) <= 1-QQ(1)/1000000),
            k)

        if sat_gt:

            sat_lt, _ = SAT(
                coeffs,
                lambda p,x: p.add_constraint(sum(x[i] for i in range(k+1)) >= 1+QQ(1)/1000000),
                k)

            if sat_lt:
                s = 0
            else:
                s = 1

        else:
            s = -1
    if s==1:
        sat_zt, _ = SAT( coeffs,
        lambda p, x: (
        p.add_constraint(sum(x[i] for i in range(k+1)) <= 1 - QQ(1)/1000000),
        p.add_constraint(sum(x[i] for i in range(k+1)) >= QQ(1)/1000000)
        ),
        k)
        if sat_zt:
            s=1
        else:
            s=2
        
    return s
    #{        "status":"SAT",  "solution":sol,"s":s    }
