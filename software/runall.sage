def runall():

    examples = [
        "benchmark/cohencu.sage",
        "benchmark/continuedfraction.sage",
        "benchmark/Example4.1.sage",
        "benchmark/Example4.2.sage",
        "benchmark/ex1.sage",
        "benchmark/ex2.sage",
        "benchmark/freire1.sage",
        "benchmark/freire2.sage",
        "benchmark/sqrt.sage"
    ]

    with open("LinearInductiveInvariantsFixedOrder_Benchmark.csv",
              "w",
              newline="") as f:

        writer = csv.writer(f)

        writer.writerow([
            "Example",
            "k",
            "Time (seconds)",
            "Status"
        ])

        for example in examples:

            print("="*60)
            print(example)

            for k in range(5):

                start = time.perf_counter()

                try:

                    phi=LinearInductiveInvariantsFixedOrder(example, k)

                    elapsed = time.perf_counter() - start
                    print(phi)
                    writer.writerow([
                        example,
                        k,
                        elapsed,
                        "Success"
                    ])

                    print("k =", k, " Time =", elapsed)

                except Exception as e:

                    elapsed = time.perf_counter() - start

                    writer.writerow([
                        example,
                        k,
                        elapsed,
                        "Error: " + str(e)
                    ])

                    print("k =", k, " Error:", e)

    print("Results saved to LinearInductiveInvariantsFixedOrder_Benchmark.csv")

