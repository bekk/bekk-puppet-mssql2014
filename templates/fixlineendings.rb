target="C:\\sql2014install.ini"
target2="C:\\sql2014install2.ini"
file_contents = File.read(target)
new_contents = file_contents.gsub(/\r(?!\n)/, "\r\n")
File.open(target, "w") {|file| file.puts new_contents }
File.open(target2, "w") {|file| file.puts new_contents }
