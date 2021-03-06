require './src/Grammar'

class App
	attr_reader :test_files

	def initialize(args)
		@test_files = args.select {|arg| arg.match /.+\.rb/}

		@test_files.each do |file|
			raise RuntimeError.new("test file not found: #{file.to_s}") if not File.exists? ("./" + file)
		end

		Grammar.parse 'ruby.grammar'

		File.open('build/app.rb', 'w') do
			|file|
			file.write "class App\ndef self.main(args)\nend\nend\nApp.main(ARGV)\n"
		end

		pwd = Dir.pwd

		system("SET PATH=#{pwd}/MinGW/mingw64/bin;%PATH% && g++.exe #{@test_files.join(' ')} build/main.cpp -o build/out.exe lgmockd lgmock_maind lgtestd lgtest_maind")
	end
end
