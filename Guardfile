guard :rspec do
  watch(%r{^.+_spec\.rb$})
  watch(%r{.+\.rb})
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
