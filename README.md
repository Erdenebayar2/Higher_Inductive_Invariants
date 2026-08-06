# Computing Higher Inductive Invariant Inequalities

This repository contains a prototype implementation of algorithms for computing and generating higher-order inductive invariants for simple loops.

The algorithms are implemented in SageMath and use QEPCAD for quantifier elimination where required.

## Requirements

The software requires:

* SageMath;
* QEPCAD;
* the SageMath QEPCAD interface.

## QEPCAD Installation

First, verify that QEPCAD is installed and accessible from SageMath.

On Ubuntu or Debian-based systems, install QEPCAD using:

```bash
sudo apt-get install qepcad
```

## Repository Structure

The repository contains:

* the SageMath implementation of the algorithms;
* a `benchmark` directory containing linear loop examples;
* scripts for running the algorithms on all benchmarks;

Each benchmark is stored in a SageMath file such as:

```text
benchmark/Example4.1.sage
```

A benchmark file typically defines the loop matrix and initial value

## Usage

Run the commands below from the main software directory in SageMath.

### Computing (C_r(a,M))

Use `computeCr` to compute the coefficient set (C_r(a,M)) for a prescribed order (r):

```
load ("main.sage")
LinearInductiveInvariantsFixedOrder(example, r)
```

For example:

```
LinearInductiveInvariantsFixedOrder("benchmark/Example4.1.sage", 5)
```

The first argument is the path to the benchmark file, and the second argument is the order (r).

### Generating Linear Higher Inductive Invariants

Use `GenerateInvariantsFixedOrder` to generate a linear higher inductive invariant for the loop (L(a,M)):

```
GenerateInvariantsFixedOrder("benchmark/<example>.sage", r)
```

#### Computing the Complete Family of All Higher Inductive invariants


```
LinearHigherInductiveInvariants("benchmark/<example>.sage")
```

For example:

```
LinearHigherInductiveInvariants("benchmark/Example4.1.sage")
```



## Benchmark Format

A benchmark file may contain data of the following form:

```python
M = matrix(QQ, [
    [1, 0, 0, 0, 1],
    [0, 1, 1, 0, 0],
    [0, 0, 1, 1, 0],
    [0, 0, 0, 1, 6],
    [0, 0, 0, 0, 1]
])

initial = [0, 0, 1, 6, 1]
```

Here:

* `M` is the matrix defining the linear loop update;
* `initial` is the initial state of the loop.

The implementation converts `initial` into a SageMath vector before constructing the initiation constraints.

## Output

Depending on the selected function, the output may be:

* a quantifier-free description of (C_r(a,M));
* a family of linear invariant inequalities;
* one feasible coefficient vector;
* several invariant inequalities;
* a complete invariant family;
* benchmark results stored in CSV format.

When `GenerateInvariantsFixedOrder` returns a vector

```text
(c1, c2, ..., cn, b)
```

it represents the linear inequality

[
c_1x_1+\cdots+c_nx_n+b>0.
]

If no admissible nontrivial invariant exists for the prescribed order, the function returns:

```python
None
```

## Notes

QEPCAD is used for general quantifier-elimination computations. When the generated constraints are linear, the implementation instead uses exact rational linear programming through SageMath's `GLPK/exact` backend.

This avoids unnecessary cylindrical algebraic decomposition and is substantially more efficient for linear constraints.

The current implementation is a research prototype and may be extended as the algorithms and benchmark collection develop.

