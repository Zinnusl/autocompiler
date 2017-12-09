require './src/Grammar'

class App
	attr_reader :test_files

	def initialize(args)
		@test_files = args.select {|arg| arg.match /.+\.cpp/}

		@test_files.each do |file|
			raise RuntimeError.new("test file not found: #{file.to_s}") if not File.exists? ("./" + file)
		end

		Grammar.parse 'cpp.grammar'

		File.open('build/main.cpp', 'w') do
			|file|
			file.write "int main() { return 0; }"
		end

		pwd = Dir.pwd

		system("SET PATH=#{pwd}/MinGW/mingw64/bin;%PATH% && g++.exe build/main.cpp -o build/out.exe")
	end
end
