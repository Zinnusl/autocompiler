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
			file.write '#include "gtest/gtest.h" 
				int main(int argc, char** argv) {
					::testing::InitGoogleTest(&argc, argv);
				  return RUN_ALL_TESTS();
			  }
			'
		end

		pwd = Dir.pwd

		system("SET PATH=#{pwd}/MinGW/mingw64/bin;%PATH% && g++.exe #{@test_files.join(' ')} build/main.cpp -o build/out.exe lgmockd lgmock_maind lgtestd lgtest_maind")
	end
end
