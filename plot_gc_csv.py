import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("gc_report.csv")

plt.figure(figsize=(10, 5))
plt.plot(df["Index"], df["GC Time (ms)"], marker='o')
plt.title("GC Pause Time per Collection")
plt.xlabel("GC Index")
plt.ylabel("GC Time (ms)")
plt.grid(True)
plt.tight_layout()
plt.savefig("gc_pause_times.png")
plt.show()

# plt.clf()
plt.figure(figsize=(10, 5))
plt.plot(df["Index"], df["Use Size (bytes)"], label="Used", marker='s')
plt.plot(df["Index"], df["Total Size (bytes)"], label="Total", marker='x')
plt.title("Heap Memory Usage over GC Passes")
plt.xlabel("GC Index")
plt.ylabel("Memory (bytes)")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.savefig("heap_usage.png")
plt.show()
