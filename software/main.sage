from sage.rings.polynomial.complex_roots import complex_roots
import time
import csv
from itertools import product
from sage.misc.sage_timeit import SageTimeitResult
from sage.combinat.cartesian_product import CartesianProduct_iters
from sage.numerical.mip import MixedIntegerLinearProgram, MIPSolverException
from sage.interfaces.qepcad import qformula 
load("quantifierElimination.sage")
load("LinearInductiveInvariantsFixedOrder.sage")
load("InductiveTest.sage")
load("runall.sage")
load("number_positive_roots.sage")
load("SelectDivisors.sage")
load("positiveDominant.sage")
load("LinearHigherInductiveInvariants.sage")
load("ConstantTest.sage")
load("GenerateInvariantsFixedOrder.sage")
load("GenerateHigherInductiveInvariants.sage")
##load("cad.sage")
R.<t> = QQ[]
S.<u> = PolynomialRing(R)
Ru.<uR> = PolynomialRing(QQ)
Rt.<tR> = PolynomialRing(Ru)
