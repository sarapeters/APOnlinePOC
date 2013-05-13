def compile_financial_statements(file)
  unless File.exist?(file)
    puts "#{file} does not exist"
    return
  end

  puts "Change detected in #{file}"
  puts "Compiling financial_statements.ap..."
  system "ruby compile financial_statements.ap"
  puts "Compiled financial_statements.ap"
  puts
end

watch(".*/*.ap") do |match|
  compile_financial_statements match[0]
end

watch(".*/*.rb") do |match|
  compile_financial_statements match[0]
end
