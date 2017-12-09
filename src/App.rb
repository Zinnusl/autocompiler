require './src/Grammar'

class App
	attr_reader :test_files

	def initialize(args)
		@test_files = args.select {|arg| arg.match /.+\.cpp/}

		Grammar.parse 'cpp.grammar'

		File.open('build/main.cpp', 'w') do
			|file|
			file.write "int main() { return 0; }"
		end

		pwd = Dir.pwd

		system("SET PATH=#{pwd}/MinGW/mingw64/bin;%PATH% && g++.exe build/main.cpp -o build/out.exe")
	end
end
