require 'ostruct'

puts " GC stats before allocation:"
puts GC.stat

GC::Profiler.enable

data = []
100_000.times do |i|
    data << OpenStruct.new(id: i, name: "Object #{i}", values: [i] * 10)
end

GC.start

puts "\n GC stats after allocation + GC.start:"
puts GC.stat

puts "\n GC::Profiler report:"
puts GC::Profiler.report
