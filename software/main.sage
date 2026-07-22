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
##load("cad.sage")
