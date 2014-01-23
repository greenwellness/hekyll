#!/usr/bin/ruby

# Dependency tree
require 'terminal-table'
require 'optparse'
require 'fileutils'
require 'securerandom'
require 'yaml'
require 'front_matter'
#require 'awesome_print'
require 'pathname'

def rnd() SecureRandom.uuid[1,5] end # one line fns need ()

input = [
         {:title => rnd, :coords => [0,0],
          :table => [["_.Aanbieder", "_.Account", "_.Doel"],
                     ['GitHub', 'greenwellness', 'experiment,document,interop'],
                     ['BitBucket', 'greenwellness', 'magento source control']]},

         {:title => rnd, :coords => [0,0],
          :table => [["_.Aanbieder", "_.Account", "_.Doel"],
                     ['GitHub', 'greenwellness', 'experiment,document,interop'],
                     ['BitBucket', 'greenwellness', 'magento source control']]},

         {:title => rnd, :coords => [0,0],
          :table => [["_.Aanbieder", "_.Account", "_.Doel"],
                     ['GitHub', 'greenwellness', 'experiment,document,interop'],
                     ['BitBucket', 'greenwellness', 'magento source control']]},

         {:title => rnd, :coords => [0,0],
          :table => [["_.Aanbieder", "_.Account", "_.Doel"],
                     ['GitHub', 'greenwellness', 'experiment,document,interop'],
                     ['BitBucket', 'greenwellness', 'magento source control']]},

         {:title => rnd, :coords => [0,0],
          :table => [["_.Aanbieder", "_.Account", "_.Doel"],
                     ['GitHub', 'greenwellness', 'experiment,document,interop'],
                     ['BitBucket', 'greenwellness', 'magento source control']]}]

i = 0
input.each do |f|
  yfm = { 'layout'    => 'slide',
          'title'     => f[:title],
          'published' => true,
          'data'      => {'x' => f[:coords[1]] + (i * 1000),
                          'y' => f[:coords[2]]}
  }.to_yaml
  i +=1
end

exit

# Input
$slide = 1
$dist = 1000

time = Time.new

def getpath
  # Path operation to drop files in
  pwd = Pathname.pwd # current dir
  #FileUtils.mkdir_p dir
  dir = pwd + "tmp/" + rnd
  return dir
end

# Loop fixed slide number
while $slide < input.count do

  title = input[$slide]
  name = time.strftime("%Y-%m-").to_str + "#$slide" + "-" + title + ".textile"

  puts "\n\n" + name

  x = 0
  y = 0

  yfm = { 'layout'    => 'slide',
          'title'     => title,
          'published' => true,
          'data'      => {'x' => x + ($slide * $dist),
                          'y' => y } }.to_yaml
  puts yfm
  puts "---"


  $slide +=1
end




exit

## Append to file (write if it doesn't exist)
#File.open(root_dir + '2014-1-1-foobar.textile', 'a') { |f| f.write('---') }

#File.open("Saves.yaml", "w") do |file|
    #file.write(YAML.dump([@characters,@saves,@settings]))
#end
#YAML.load File.read "2014-1-1-sample.textile"

## Help printing
#option_parser = OptionParser.new do |opts|
  #opts.on('-o', '--output FILENAME', 'Output filename - required') do |filename|
    #files[:output] = filename
  #end
#end

#File.open("out.txt", 'OPTION') {|f| f.write("write your stuff here") }

rows = []
rows << ['GitHub', 'greenwellness', 'experiment,document,interop']
rows << ['BitBucket', 'greenwellness', 'magento source control']

# Construct table object
table = Terminal::Table.new

# Populate headings (in textile: `_.` immediately after `|` to denote headings)
# Meaning, keep :padding_left to value 0
table.headings = ["_.Aanbieder", "_.Account", "_.Doel"]

# Populate rows
table.rows = rows

# Set the style of the table
table.style = {:width => 80, :padding_left => 0, :border_x => " ", :border_i => "|"}

# Print to console
puts table


# Alternative onliner
#table = Terminal::Table.new :headings => [{:value => "_.Word"  , :alignment => :left},
#                                          {:value => "_.Number", :alignment => :left}], :rows => rows
