require 'ostruct'
require 'benchmark'
require 'csv'

def print_gc_stats(title)
  stats = GC.stat
  puts "\n=== #{title} ==="
  puts "GC count: #{stats[:count]}"
  puts "Total allocated objects: #{stats[:total_allocated_objects]}"
  puts "Total freed objects: #{stats[:total_freed_objects]}"
  puts "Minor GC count: #{stats[:minor_gc_count]}"
  puts "Major GC count: #{stats[:major_gc_count]}"
  puts "Heap used: #{stats[:heap_used]}"
end

def save_profiler_to_csv(filename)
  raw_report = GC::Profiler.raw_data

  CSV.open(filename, "w") do |csv|
    csv << ["Index", "Invoke Time (s)", "Use Size (bytes)", "Total Size (bytes)", "Total Object", "GC Time (ms)"]

    raw_report.each_with_index do |entry, idx|
      csv << [
        idx + 1,
        entry[:GC_INVOKE_TIME],
        entry[:HEAP_USE_SIZE],
        entry[:HEAP_TOTAL_SIZE],
        entry[:HEAP_TOTAL_OBJECTS],
        (entry[:GC_TIME] * 1000).round(3) # convert to ms
      ]
    end
  end

  puts "\nGC profiler data saved to #{filename}"
end

puts "Starting Garbage Collection Test..."

print_gc_stats("GC statistics BEFORE allocation")

GC::Profiler.enable

allocation_time = Benchmark.realtime do
  @data = []
  100_000.times do |i|
    @data << OpenStruct.new(id: i, name: "Object #{i}", values: [i] * 10)
  end
end

GC.start

print_gc_stats("GC statistics AFTER allocation + GC.start")

puts "\n=== Allocation Time ==="
puts "Total time to allocate objects: #{allocation_time.round(3)} seconds"

puts "\n=== GC Profiler Report (console) ==="
puts GC::Profiler.report

save_profiler_to_csv("gc_report.csv")
