# Construct the Sturm sequence
# ----------------------------------------------------------
def sturm_sequence(f):

    if f == 0:
        raise ValueError("The zero polynomial has infinitely many roots.")

    if f.degree() == 0:
        return [f]

    # Remove repeated factors
    d = f.gcd(f.derivative())
    if d.degree() > 0:
        q, r = f.quo_rem(d)
        assert r == 0
        f = q

    S = [f, f.derivative()]

    while S[-1] != 0:
        q, r = S[-2].quo_rem(S[-1])
        if r == 0:
            break
        S.append(-r)

    return S


# ----------------------------------------------------------
# Count sign changes (ignoring zeros)
# ----------------------------------------------------------
def sign_variations(signs):

    s = [x for x in signs if x != 0]

    count = 0
    for i in range(len(s)-1):
        if s[i] != s[i+1]:
            count += 1

    return count


# ----------------------------------------------------------
# Sign of polynomial at +infinity
# ----------------------------------------------------------
def sign_at_plus_infinity(p):

    if p == 0:
        return 0

    lc = p.leading_coefficient()

    if lc > 0:
        return 1
    elif lc < 0:
        return -1
    else:
        return 0


# ----------------------------------------------------------
# Number of distinct positive real roots
# ----------------------------------------------------------
def number_positive_roots(f):

    if f == 0:
        raise ValueError("The zero polynomial has infinitely many roots.")

    if f.degree() == 0:
        return 0

    S = sturm_sequence(f)

    # -------- sign variations at x = 0 --------

    signs0 = []

    for g in S:
        v = g(0)

        if v > 0:
            signs0.append(1)
        elif v < 0:
            signs0.append(-1)
        else:
            signs0.append(0)

    V0 = sign_variations(signs0)

    # -------- sign variations at +infinity --------

    signsInf = []

    for g in S:

        s = sign_at_plus_infinity(g)

        # odd degree changes the sign at -infinity,
        # but at +infinity only the leading coefficient matters.
        signsInf.append(s)

    VInf = sign_variations(signsInf)

    return V0 - VInf

#----------------------------------------------------------
# Sign of polynomial at x
#----------------------------------------------------------
def sign_at(p, x):

    if x == +Infinity:
        return sign_at_plus_infinity(p)

    if x == -Infinity:
        s = sign_at_plus_infinity(p)
        if p.degree() % 2 == 1:
            return -s
        return s

    val = p(x)

    if val > 0:
        return 1
    elif val < 0:
        return -1
    else:
        return 0


#----------------------------------------------------------
# Sturm count on (a,b)
#----------------------------------------------------------
def sturm_count(f, a, b):

    S = sturm_sequence(f)

    Va = sign_variations([sign_at(p, a) for p in S])
    Vb = sign_variations([sign_at(p, b) for p in S])

    return Va - Vb
