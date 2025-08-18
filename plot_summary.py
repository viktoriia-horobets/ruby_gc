import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("summary.csv", skiprows=1)  
plt.figure(figsize=(10, 6))

bar_width = 0.25
x = range(len(df))

plt.bar([i - bar_width for i in x], df["Total GC Time (ms)"], width=bar_width, label="Total GC Time (ms)")
plt.bar(x, df["Max GC Pause (ms)"], width=bar_width, label="Max GC Pause (ms)")
plt.bar([i + bar_width for i in x], df["GC Count"], width=bar_width, label="GC Count")

plt.xlabel("RUBY_GC_HEAP_GROWTH_FACTOR")
plt.xticks(ticks=x, labels=df["HEAP_GROWTH_FACTOR"])
plt.ylabel("Value")
plt.title("Comparison of GC Performance Metrics")
plt.legend()
plt.tight_layout()

plt.savefig("gc_summary_comparison.png")
plt.show()
