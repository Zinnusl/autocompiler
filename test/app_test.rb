require './src/App'

describe App do
	before :each do
		File.delete "build/out.exe" if File.exists? "build/out.exe"
	end

	it 'should parse a grammar file on start' do
		expect(File).to receive(:read).with(/\.grammar/).and_return("`a` -> `b`\n`b` -> `c`\n")

		app = App.new [""]
	end
	it 'should accept a list of cpp source files (test files)' do
		args = [ "test/passing_unit_test.cpp", "test/failing_unit_test.cpp"]

		app = App.new args

		expect(app.test_files).to match_array(["test/failing_unit_test.cpp", "test/passing_unit_test.cpp"])
	end
	it 'should output a error if one of the input test files was not found' do
		args = ["test/passing_unit_test.cpp", "test/failing_unit_test.cpp", "non_existant.cpp"]

		expect { app = App.new args }.to raise_error(RuntimeError, /test file not found/)

		args = ["test/passing_unit_test.cpp", "test/failing_unit_test.cpp"]

		expect { app = App.new args }.not_to raise_error
	end

	it 'should create a executable (.exe)' do
		expect(File.exists? "build/out.exe").to eq false

		app = App.new [""]

		expect(File.exists? "build/out.exe").to eq true
	end
	describe 'executable' do
		it 'should accept the tests option' do
			app = App.new [""]
			expect(system("./build/out.exe tests")).to eq true
		end
		describe 'tests option' do
			it 'should execute the google unit tests' do
				app = App.new ["test/failing_unit_test.cpp"]
				expect(system("./build/out.exe tests")).to eq false

				app = App.new ["test/passing_unit_test.cpp"]
				expect(system("./build/out.exe tests")).to eq true
			end
		end
	end
end
