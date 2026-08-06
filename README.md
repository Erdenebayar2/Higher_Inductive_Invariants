# Computing Higher Inductive Invariant Inequalities

This repository contains a prototype implementation of algorithms for computing and generating higher inductive invariants for simple loops.

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

* a `software` directory containing the SageMath implementation of the algorithms;
* a `benchmark` directory containing linear-loop examples;
* scripts for running the algorithms on all benchmarks.

Each benchmark is stored in a SageMath file, such as:

```text
benchmark/Example4.1.sage
```

A benchmark file typically defines the loop matrix and the initial value.

## Usage

Run the commands below from the main software directory in SageMath.

First, load the main implementation file:

```python
load("main.sage")
```

### Computing (C_r(a,M))

Use `LinearInductiveInvariantsFixedOrder` to compute the coefficient set (C_r(a,M)) for a prescribed order (r):

```python
LinearInductiveInvariantsFixedOrder(example, r)
```

For example:

```python
LinearInductiveInvariantsFixedOrder("benchmark/Example4.1.sage", 5)
```

The first argument is the path to the benchmark file, and the second argument is the order (r).

The function returns a quantifier-free logical formula describing all coefficient vectors belonging to (C_r(a,M)).

### Generating Linear Higher Inductive Invariants

Use `GenerateInvariantsFixedOrder` to generate a linear higher inductive invariant for the loop (L(a,M)):

```python
GenerateInvariantsFixedOrder("benchmark/<example>.sage", r)
```

The function returns one feasible coefficient vector defining a nontrivial linear higher inductive invariant of order (r).

The returned vector contains the coefficients of the corresponding linear polynomial. If no coefficient vector satisfying all constraints exists, the function returns `None`.

#### Computing the Complete Family of All Higher Inductive Invariants

Use:

```python
LinearHigherInductiveInvariants("benchmark/<example>.sage")
```

For example:

```python
LinearHigherInductiveInvariants("benchmark/Example4.1.sage")
```

The function returns a quantifier-free logical formula describing the complete family of coefficient vectors defining linear higher inductive invariant inequalities, together with the stabilization order.

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
