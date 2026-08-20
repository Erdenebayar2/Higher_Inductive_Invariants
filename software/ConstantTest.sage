def ConstantTest(g):
    if number_positive_roots(g) >= 1:
        if g(1) == 0:
            return 0
        elif  number_positive_roots(g(t+1))>= 1:
            return -1
        else:
            return 1
    elif SelectDivisors((t - 1) * g):
        return 0
    else:
        return -1
