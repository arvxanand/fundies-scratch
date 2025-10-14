use context dcic2024

include csv
include data-source

flights = load-table:
  
  
  
  
  source: csv-table-file("flights.csv", default-options)
  sanitize rownames using num-sanitizer
end
