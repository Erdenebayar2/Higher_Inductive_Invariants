#-----------------------------------------------------------
# Construct the Sturm sequence
#-----------------------------------------------------------
def sturm_sequence(f):
    f1 = f.gcd(f.derivative())
    print(f1)
    f, r = f.quo_rem(f1)
    #print(f,r)
    S = [f, f.derivative()]
    print(S)
    while True:
        _, r = S[-2].quo_rem(S[-1])
        if r == 0:
            break
        S.append(-r)

    return S


#-----------------------------------------------------------
# Count sign variations
#-----------------------------------------------------------
def sign_variations(signs):
    # Remove zeros
    signs = [s for s in signs if s != 0]

    count = 0
    for i in range(len(signs)-1):
        if signs[i] != signs[i+1]:
            count += 1
    return count


#-----------------------------------------------------------
# Sign of polynomial at +infinity
#-----------------------------------------------------------
def sign_at_plus_infinity(p):
    #print(p)
    if p.leading_coefficient() > 0:
        return 1
    else:
        return -1


#-----------------------------------------------------------
# Number of positive real roots
#-----------------------------------------------------------
def number_positive_roots(f):

    S = sturm_sequence(f)
    #print(S)
    # Signs at x = 0
    signs0 = []
    for g in S:
        val = g(0)
        if val > 0:
            signs0.append(1)
        elif val < 0:
            signs0.append(-1)
        else:
            signs0.append(0)

    V0 = sign_variations(signs0)
    #print(V0)
    # Signs at +infinity
    signs_inf = [sign_at_plus_infinity(g) for g in S]
    Vinf = sign_variations(signs_inf)

    return V0 - Vinf

