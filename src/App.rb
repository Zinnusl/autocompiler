class App
	attr_reader :test_files

	def initialize(args)
		@test_files = args.select {|arg| arg.match /.+\.cpp/}

		File.open('build/out.exe', 'w') do |file|
			file.write "test"
		end
	end
end
