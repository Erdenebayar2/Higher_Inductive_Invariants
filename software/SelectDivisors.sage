def SelectDivisors(g):
    # computing the number of positive roots without multiplicity
    distinct_positive_roots=number_positive_roots(g)
    print(distinct_positive_roots)
    if distinct_positive_roots>1:
        #print("More than 1 positive root")
        return False
    elif distinct_positive_roots==1:
    # checking whether the multiplicity of the positive root is greater than 1
        if number_positive_roots(g.gcd(g.derivative())) ==1:
            #print("The positive root is not simple")
            return False
        else:
            # finding an irreducible factor whose root is the positive root of g
            F = g.factor()
            for h, e in F:
                if number_positive_roots(h) > 0:
                    P_alpha = h
                    break
            #print(P_alpha)
            g_all = g(-t)* g
            #check that the absolute value of any negative root is greater than the positive root
            interval_max=g_all.real_root_intervals()[-1][0]
            if sturm_count(P_alpha,interval_max[0],interval_max[1])==0:
                print("Not dominant - negative")
                return False
            else:
                d = g.degree()
                q = S(0)
                for i, c in enumerate(g.list()):
                    q += c * t^i * u^(d-i)
                #V-roots are the products of pairs of q-roots
                V = g(u).resultant(q)
                #return V
                interval_max = V.real_root_intervals()[-1][0]
                #print(interval_max)
                #check the positive root is inside the interval_max. If yes, it is the dominant root; otherwise, the positive root is not dominant
                A = P_alpha(u).resultant(u^2-t)
                #print(P_alpha.real_roots())
                #print(A.factor())
                #print(A.real_roots())
                if sturm_count(A,interval_max[0],interval_max[1]) ==0:
                    #print("Not dominant-complex")
                    return False
                else:
                    d = P_alpha.degree()
                    q = S(0)
                    for i, c in enumerate(P_alpha.list()):
                        q += c * t^i * u^(d-i)
                    #P_salpha =P_alpha(u).resultant(q)
                    #P_salpha = (P_salpha // P_salpha.gcd(P_salpha.derivative())).monic()
                    #print(P_salpha.factor())
                    #print(g)
                    #print(g.factor())
                    h_lcm=1
                    for f, e in g.factor():
                        print("Factorf:", f)
                        if f == P_alpha:
                            q = S(0)
                            d = f.degree()
                            for i, c in enumerate(f.list()):
                                q += c * t^i * u^(d-i)
                            Vf = f(u).resultant(q)
                            h_lcm =lcm(h_lcm,(Vf).real_root_intervals()[-1][1])
                            continue
                        q = S(0)
                        d = f.degree()
                        for i, c in enumerate(f.list()):
                            q += c * t^i * u^(d-i)
                        Vf = f(u).resultant(q)
                        Vf_mult = Vf
                        Vf = (Vf // Vf.gcd(Vf.derivative())).monic()
                        interval_max = (A*Vf).real_root_intervals()[-1][0]
                        #print(sturm_count(Vf,interval_max[0],interval_max[1]))
                        if sturm_count(Vf,interval_max[0],interval_max[1])==1:
                            #print("faa")
                            #print(f)
                            if e>1:
                                print("A dominant root has mult >1")
                                return False
                            else:
                                m = Vf_mult.real_root_intervals()[-1][1]
                                print("m")
                                print(m)
                                h =1
                                #print("f")
                                #print(f)
                                found = False
                                br =0
                                for k in range(2, 8 * (f.degree())^2+1):
                                    if br ==1:
                                        break
                                    print("degree")
                                    print(k)
                                    f_test = f(u).resultant(u^k - t)
                                    #print(f_test)
                                    if positiveDominant(f_test):
                                        print("Yeah")
                                        found = True
                                        h = lcm(h,k)
                                        for k in divisors(h):
                                            print(k)
                                            f_test = f(u).resultant(u^k - t)
                                            print("check")
                                            print(f_test.real_root_intervals())
                                            if positiveDominant(f_test):
                                                print(f_test.real_root_intervals()[-1][1])
                                                if m ==f_test.real_root_intervals()[-1][1]:
                                                    h_prime = k
                                                    h_lcm = lcm(h_lcm,h_prime)
                                                    br =1
                                                    break
                                if not found:
                                    print("not root of unity")
                                    return False         
                    print("h_lcm")
                    print(h_lcm)
                    g_test = g(u).resultant(u^(h_lcm)-t)
                    if number_positive_roots(g_test)>1:
                        print("Last condition failed")
                        return False
                    else:
                        return (True, h_lcm)                    
    else:
        return True
