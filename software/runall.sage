def runallFixed():

    examples = [
        "benchmark/cohencu.sage",
        "benchmark/continuedfraction.sage",
        "benchmark/Example4.1.sage",
        "benchmark/Example4.2.sage",
        "benchmark/Example4.3.sage",
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
    

def runallHigher():
    import csv
    import os
    import traceback

    examples = [
        "benchmark/cohencu.sage",
        "benchmark/continuedfraction.sage",
        "benchmark/Example4.1.sage",
        "benchmark/Example4.2.sage",
        "benchmark/Example4.3.sage",
        "benchmark/ex1.sage",
        "benchmark/ex2.sage",
        "benchmark/freire1.sage",
        "benchmark/freire2.sage",
        "benchmark/sqrt.sage"
    ]

    output_directory = "benchmark_results"
    os.makedirs(output_directory, exist_ok=True)

    csv_file = os.path.join(
        output_directory,
        "running_times_Higher.csv"
    )

    text_file = os.path.join(
        output_directory,
        "outputs.txt"
    )

    all_results = []

    for example in examples:
        benchmark_name = os.path.splitext(
            os.path.basename(example)
        )[0]

        print("\n" + "=" * 70)
        print("Benchmark:", benchmark_name)
        print("File:", example)
        print("=" * 70)

        start_time = walltime()

        try:
            output = LinearHigherInductiveInvariants(example)
            running_time = walltime(start_time)

            # Convert the formula output to text before storing it.
            output_string = str(output)

            result = {
                "benchmark": benchmark_name,
                "file": example,
                "status": "success",
                "running_time": running_time,
                "output": output_string,
                "error": ""
            }

            print("Status: success")
            print("Running time:", running_time, "seconds")
            print("Output:")
            print(output_string)

        except Exception:
            running_time = walltime(start_time)
            error_message = traceback.format_exc()

            result = {
                "benchmark": benchmark_name,
                "file": example,
                "status": "failed",
                "running_time": running_time,
                "output": "",
                "error": error_message
            }

            print("Status: failed")
            print("Running time:", running_time, "seconds")
            print(error_message)

        all_results.append(result)

    # Save running times and outputs in a CSV file.
    with open(csv_file, "w", newline="", encoding="utf-8") as file:
        writer = csv.writer(file)

        writer.writerow([
            "Benchmark",
            "Status",
            "Running time",
            "Output"
        ])

        for result in all_results:
            writer.writerow([
                result["benchmark"],
                result["status"],
                result["running_time"],
                result["output"]
            ])

    # Save readable results in a text file.
    with open(text_file, "w", encoding="utf-8") as file:
        for result in all_results:
            file.write("=" * 80 + "\n")
            file.write(
                "Benchmark: {}\n".format(
                    result["benchmark"]
                )
            )
            file.write(
                "File: {}\n".format(
                    result["file"]
                )
            )
            file.write(
                "Status: {}\n".format(
                    result["status"]
                )
            )
            file.write(
                "Running time: {:.6f} seconds\n".format(
                    result["running_time"]
                )
            )

            if result["status"] == "success":
                file.write("Output:\n")
                file.write(result["output"])
                file.write("\n")
            else:
                file.write("Error:\n")
                file.write(result["error"])
                file.write("\n")

            file.write("\n")

    print("\n" + "=" * 70)
    print("All benchmark computations finished.")
    print("Running times and outputs saved in:", csv_file)
    print("Readable outputs saved in:", text_file)
    print("=" * 70)

    return all_results
import csv
import os
import time
import traceback


def runallGenerate():

    examples = [
        "benchmark/cohencu.sage",
        "benchmark/continuedfraction.sage",
        "benchmark/Example4.1.sage",
        "benchmark/Example4.2.sage",
        "benchmark/Example4.3.sage",
        "benchmark/ex1.sage",
        "benchmark/ex2.sage",
        "benchmark/freire1.sage",
        "benchmark/freire2.sage",
        "benchmark/sqrt.sage"
    ]

    results = []

    output_directory = "benchmark_results"
    os.makedirs(output_directory, exist_ok=True)

    csv_file = os.path.join(
        output_directory,
        "fixed_order_results.csv"
    )

    for example in examples:

        benchmark_name = os.path.splitext(
            os.path.basename(example)
        )[0]

        print("=" * 60)
        print("Benchmark:", benchmark_name)
        print("=" * 60)

        for k in range(5):

            print("Running k =", k)

            start_time = time.perf_counter()

            try:
                output = GenerateInvariantsFixedOrder(example, k)

                running_time = time.perf_counter() - start_time

                result = {
                    "benchmark": benchmark_name,
                    "file": example,
                    "k": k,
                    "status": "success",
                    "running_time": running_time,
                    "output": str(output),
                    "error": ""
                }

                print("Output:", output)
                print("Running time:", running_time, "seconds")

            except Exception as error:

                running_time = time.perf_counter() - start_time

                result = {
                    "benchmark": benchmark_name,
                    "file": example,
                    "k": k,
                    "status": "error",
                    "running_time": running_time,
                    "output": "",
                    "error": traceback.format_exc()
                }

                print("Error:", error)
                print("Running time:", running_time, "seconds")

            results.append(result)

            with open(
                csv_file,
                "w",
                newline="",
                encoding="utf-8"
            ) as csv_output:

                fieldnames = [
                    "benchmark",
                    "file",
                    "k",
                    "status",
                    "running_time",
                    "output",
                    "error"
                ]

                writer = csv.DictWriter(
                    csv_output,
                    fieldnames=fieldnames
                )

                writer.writeheader()
                writer.writerows(results)

    print()
    print("All benchmark computations finished.")
    print("Results saved to:", csv_file)

    return results

def runallHigherGenerate():
    import csv
    import os
    import traceback

    examples = [
        "benchmark/cohencu.sage",
        "benchmark/continuedfraction.sage",
        "benchmark/Example4.1.sage",
        "benchmark/Example4.2.sage",
        "benchmark/Example4.3.sage",
        "benchmark/ex1.sage",
        "benchmark/ex2.sage",
        "benchmark/freire1.sage",
        "benchmark/freire2.sage",
        "benchmark/sqrt.sage"
    ]

    output_directory = "benchmark_results"
    os.makedirs(output_directory, exist_ok=True)

    csv_file = os.path.join(
        output_directory,
        "running_times_GenerateHigher.csv"
    )

    text_file = os.path.join(
        output_directory,
        "outputs.txt"
    )

    all_results = []

    for example in examples:
        benchmark_name = os.path.splitext(
            os.path.basename(example)
        )[0]

        print("\n" + "=" * 70)
        print("Benchmark:", benchmark_name)
        print("File:", example)
        print("=" * 70)

        start_time = walltime()

        try:
            output = GenerateHigherInductiveInvariants(example)
            running_time = walltime(start_time)

            # Convert the formula output to text before storing it.
            output_string = str(output)

            result = {
                "benchmark": benchmark_name,
                "file": example,
                "status": "success",
                "running_time": running_time,
                "output": output_string,
                "error": ""
            }

            print("Status: success")
            print("Running time:", running_time, "seconds")
            print("Output:")
            print(output_string)

        except Exception:
            running_time = walltime(start_time)
            error_message = traceback.format_exc()

            result = {
                "benchmark": benchmark_name,
                "file": example,
                "status": "failed",
                "running_time": running_time,
                "output": "",
                "error": error_message
            }

            print("Status: failed")
            print("Running time:", running_time, "seconds")
            print(error_message)

        all_results.append(result)

    # Save running times and outputs in a CSV file.
    with open(csv_file, "w", newline="", encoding="utf-8") as file:
        writer = csv.writer(file)

        writer.writerow([
            "Benchmark",
            "Status",
            "Running time",
            "Output"
        ])

        for result in all_results:
            writer.writerow([
                result["benchmark"],
                result["status"],
                result["running_time"],
                result["output"]
            ])

    # Save readable results in a text file.
    with open(text_file, "w", encoding="utf-8") as file:
        for result in all_results:
            file.write("=" * 80 + "\n")
            file.write(
                "Benchmark: {}\n".format(
                    result["benchmark"]
                )
            )
            file.write(
                "File: {}\n".format(
                    result["file"]
                )
            )
            file.write(
                "Status: {}\n".format(
                    result["status"]
                )
            )
            file.write(
                "Running time: {:.6f} seconds\n".format(
                    result["running_time"]
                )
            )

            if result["status"] == "success":
                file.write("Output:\n")
                file.write(result["output"])
                file.write("\n")
            else:
                file.write("Error:\n")
                file.write(result["error"])
                file.write("\n")

            file.write("\n")

    print("\n" + "=" * 70)
    print("All benchmark computations finished.")
    print("Running times and outputs saved in:", csv_file)
    print("Readable outputs saved in:", text_file)
    print("=" * 70)

    return all_results
