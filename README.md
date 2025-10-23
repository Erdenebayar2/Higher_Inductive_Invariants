1. Check QEPCAD Installation. Ensure that the QEPCAD package is installed and working. If it is not installed, run the following command in your terminal:
            sudo apt-get install qepcad
2. Compute C_r(a,M):
computeCr("benchmark/'example'.sage",r). For example: computeCr("benchmark/Example4.1.sage",5)
3. Generate an rth inductive invariant for the loop L(a,M). You can choose among three options:
a. Compute the smallest reachable set, use command <br>
    generateInvariant("benchmark/'example'.sage",r, "All")<br>
b. Generate several inductive invariants:<br>
    generateInvariant("benchmark/ex2.sage",1, "some")<br>
c. Generate an inductive invariant, use command<br>
    generateInvariant("benchmark/ex2.sage",1, "any")<br>
