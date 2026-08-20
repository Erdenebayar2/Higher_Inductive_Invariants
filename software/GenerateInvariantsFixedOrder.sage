def GenerateInvariantsFixedOrder(example, k):
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
    initial_vector = vector(QQ, initial)

    for g in G:

        s = InductiveTest(g, k)

        if s == -2:
            continue

        Kg = g(M).transpose().right_kernel()
        Wg = Kg.basis_matrix().right_kernel().basis_matrix()

        n = len(c)
        n_cc = len(cc)

        for j in range(n_cc):

            for sign in [1, -1]:

                p = MixedIntegerLinearProgram(
                    maximization=False,
                    solver="GLPK/exact"
                )

                x = p.new_variable(
                    real=True,
                    nonnegative=False,
                    name="c"
                )

                for row in Wg.rows():

                    linear_expression = p.sum(
                        row[t] * x[t]
                        for t in range(n_cc)
                    )

                    p.add_constraint(linear_expression == 0)

                if s == 1:
                    p.add_constraint(x[n - 1] >= 0)

                elif s == -1:
                    p.add_constraint(x[n - 1] <= 0)

                elif s == 2:
                    p.add_constraint(x[n - 1] >= 1)

                # Exclude vectors of the form (0, ..., 0, a)
                if sign == 1:
                    p.add_constraint(x[j] >= 1)
                else:
                    p.add_constraint(x[j] <= -1)

                # Add:
                # l(initial) > 0, ..., l(M^(k-1) initial) > 0
                current_point = initial_vector

                for i in range(k):

                    initial_condition = (
                        p.sum(
                            current_point[t] * x[t]
                            for t in range(n_cc)
                        )
                        + x[n - 1]
                    )

                    p.add_constraint(initial_condition >= 1)

                    current_point = M * current_point

                p.set_objective(0)

                try:
                    p.solve()

                    solution = vector(QQ, [
                        p.get_values(x[t])
                        for t in range(n)
                    ])

                    return solution

                except MIPSolverException:
                    continue

    return None
