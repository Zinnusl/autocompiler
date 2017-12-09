require './src/App'

describe App do
	it 'should parse a grammar file on start' do
		expect(File).to receive(:read).with(/\.grammar/).and_return("`a` -> `b`\n`b` -> `c`\n")

		app = App.new [""]
	end
	it 'should accept a list of cpp source files' do
		args = [ "a.cpp", "b.cpp", "c.cpp", "ruby.rb"]

		app = App.new args

		expect(app.test_files).to match_array(["a.cpp", "b.cpp", "c.cpp"])
	end

	it 'should create a executable (.exe)' do
		file = double('file')
		expect(File).to receive(:open).with("build/out.exe", "w").and_yield(file)
		expect(file).to receive(:write).with("test")

		app = App.new [""]
	end
	describe 'executable' do
		it 'should accept the tests option' do
			File.open('build/main.cpp', 'w') do
				|file|
				file.write "int main() { return 0; }"
			end

			pwd = Dir.pwd

			expect(system("SET PATH=#{pwd}/MinGW/mingw64/bin;%PATH% && g++.exe build/main.cpp -o build/out.exe")).to eq true
			expect(system("./build/out.exe tests")).to eq true
		end
	end
end
