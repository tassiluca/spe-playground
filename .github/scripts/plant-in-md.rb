require 'find'

def plantuml_installed?
  system("command -v plantuml > /dev/null 2>&1")
end

unless plantuml_installed?
  puts "PlantUML is not installed. Please install it first."
  exit 1
end

if ARGV.length != 1 || !File.directory?(ARGV[0])
  puts "A script to embed PlantUML diagrams in markdown files."
  puts ""
  puts "Usage: plant-in-md.rb <directory>"
  puts ""
  puts "Arguments:"
  puts "  <directory> - The directory to search recursively for markdown files"
  exit 1
end

def generate_svg_diagrams(path)
  system("plantuml -tsvg #{path}")
end

def update_md(path)
  content = File.read(path)
  updated_content = content.gsub(/```plantuml\n(@start\w+)\s+(\w+)\n(.*?)\n```/m) do
    diagram_name = $2
    "![#{diagram_name} plantuml diagram](#{diagram_name}.svg)"
  end
  File.write(path, updated_content)
end

def process_md_files(directory)
  Find.find(directory) do |path|
    if File.file?(path) && File.extname(path) == ".md"
      generate_svg_diagrams(path)
      update_md(path)
    end
  end
end

root_directory = ARGV[0]
puts "Processing markdown files in #{root_directory}..."
process_md_files(root_directory)
puts "Done."
