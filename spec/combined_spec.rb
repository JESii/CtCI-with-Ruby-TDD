# All the specs, so that a simple rspec spec works as expected

def require_all_chapter_files
  dirs = Dir.foreach("./").map {|f| f if f =~ /chapter/ }.compact
  puts "#{dirs}"
  dirs.each do |d|
    Dir.foreach(d).map do |f|
      next if f !~ /rb$/
      puts "requiring file: ../#{d}/#{f}"
      require_relative "../#{d}/#{f}"
    end
  end
end

require_all_chapter_files()
