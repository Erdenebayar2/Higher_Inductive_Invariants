# Instructions for Using the Software

## 1. Check QEPCAD Installation

Ensure that the **QEPCAD** package is installed and working.  
If it is not installed, run the following command in your terminal:

```bash
sudo apt-get install qepcad
```

---

## 2. Compute \( C_r(a, M) \)

Use the following command to compute \( C_r(a, M) \):

```python
computeCr("benchmark/<example>.sage", r)
```

**Example:**

```python
computeCr("benchmark/Example4.1.sage", 5)
```

---

## 3. Generate the \( r \)-th Inductive Invariant for the Loop \( L(a, M) \)

You can choose among three options:

### a. Compute the smallest reachable set
```python
generateInvariant("benchmark/<example>.sage", r, "All")
```

### b. Generate several inductive invariants
```python
generateInvariant("benchmark/ex2.sage", 1, "some")
```

### c. Generate a single inductive invariant
```python
generateInvariant("benchmark/ex2.sage", 1, "any")
```
