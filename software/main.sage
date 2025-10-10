from sage.rings.polynomial.complex_roots import complex_roots
import time
from sage.misc.sage_timeit import SageTimeitResult
from sage.combinat.cartesian_product import CartesianProduct_iters
from sage.interfaces.qepcad import qformula
load("multiplicity.sage")
load("checkInvariant.sage")
load("computeCr.sage")
load("candidates.sage")
load("convertmult.sage")
load("rationaljordanform.sage")
load("mergevectors.sage")
load("checkInvariant.sage")
load("multMatrices.sage")
load("logicalformula.sage")
load("generateInvariant.sage")
load("runall.sage")
load("quantifierElimination.sage")
##load("cad.sage")
R.<x> = PolynomialRing(QQ)
