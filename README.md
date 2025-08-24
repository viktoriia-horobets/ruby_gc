# Ruby Garbage Collector

This project explores the internal behavior of the **Ruby Generational Garbage Collector (RGenGC)** by simulating memory allocation pressure and analyzing the impact of tuning the `RUBY_GC_HEAP_GROWTH_FACTOR` environment variable.

To determine how different heap growth configurations affect:
- GC pause time
- Memory usage
- GC frequency


The Ruby script `gc_new.rb` creates 100,000 complex objects (`OpenStruct`) and records GC profiling data using `GC::Profiler`.

Tested values of `RUBY_GC_HEAP_GROWTH_FACTOR`:
- `default`
- `1.2`
- `1.5`
- `1.8`
- `2.0`

Each run generates a CSV file (e.g., `gc_1.2.csv`, `gc_2.0.csv`) with metrics such as:
- GC Time (ms)
- Heap Use Size
- Total Heap Size
- Total Object Count

Visualizations
- `plot_gc_csv.py` — generates plots for GC pause time and heap usage from individual CSVs.
- `generate_summary.py` — aggregates all runs into `summary.csv`.
- `plot_summary.py` — visualizes total GC time, max pause, and number of GC passes for each configuration.

*Interactive Dashboards
`dashboard.html`
Upload CSV files and interactively compare:
- GC pause durations
- Heap memory usage
- Summary stats and histogram

`interactive_slider.html`
Step through each GC pass with a timeline slider and observe:
- GC Time (ms)
- Memory usage (Used / Total)

