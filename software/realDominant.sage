def realDominant(g):
    d = g.degree()
    q = S(0)
    for i, c in enumerate(g.list()):
        q += c * t^i * u^(d-i)
    #V-roots are the products of pairs of q-roots
    V = g(u).resultant(q)
    #return V
    interval_max = V.real_root_intervals()[-1][0]
    print(interval_max)
    A = g(u).resultant(u^2-t)
    if sturm_count(A,interval_max[0],interval_max[1]) ==0:
        print("Not dominant-complex")
        return False
    return True
