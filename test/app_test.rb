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
		File.delete "build/out.exe"
		expect(File.exists? "build/out.exe").to eq false

		app = App.new [""]

		expect(File.exists? "build/out.exe").to eq true
	end
	describe 'executable' do
		it 'should accept the tests option' do
			app = App.new [""]
			expect(system("./build/out.exe tests")).to eq true
		end
	end
end
