def runall(r, l):
    examples = ["benchmark/cohencu.sage", "benchmark/freire1.sage", "benchmark/freire2.sage", "benchmark/sqrt.sage","benchmark/ex1.sage"]
    i=0
    while i< len(examples):
        g=0
        sa=0
        ss=0
        j =0
        while j<l:
            g1 = time.time()
            phi = generateInvariant(examples[i],r)
            g2 = time.time()
            g = g+g2-g1
            sa1 = time.time()
            psi = SmallReachableSet(examples[i],r,phi,'All')
            sa2 =time.time()
            sa = sa+sa2-sa1
            ss1 = time.time()
            psi = SmallReachableSet(examples[i],r,phi,'some')
            ss2 =time.time()
            ss = ss+ss2-ss1
            j = j+1
        print(examples[i])
        print("Runtime for finding C_r is ",g/l)
        print("Runtime for computing smallest set is ", sa/l)
        print("Runtime for synthesizing some invariants is", ss/l)
        i=i+1
