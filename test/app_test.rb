require './src/App'

describe App do
	before :each do
		File.delete "build/app.rb" if File.exists? "build/app.rb"
	end

	it 'should parse a grammar file on start' do
		expect(File).to receive(:read).with(/\.grammar/).and_return("`a` -> `b`\n`b` -> `c`\n")

		app = App.new [""]
	end
	it 'should accept a list of ruby source files (test files)' do
		args = [ "test/passing_unit_test.rb", "test/failing_unit_test.rb"]

		app = App.new args

		expect(app.test_files).to match_array(["test/failing_unit_test.rb", "test/passing_unit_test.rb"])
	end
	it 'should output a error if one of the input test files was not found' do
		args = ["test/passing_unit_test.rb", "test/failing_unit_test.rb", "non_existant.rb"]

		expect { app = App.new args }.to raise_error(RuntimeError, /test file not found/)

		args = ["test/passing_unit_test.rb", "test/failing_unit_test.rb"]

		expect { app = App.new args }.not_to raise_error
	end

	it 'should create a ruby application' do
		expect(File.exists? "build/app.rb").to eq false

		app = App.new [""]

		expect(File.exists? "build/app.rb").to eq true
	end
	describe 'executable' do
		it 'should accept the tests option' do
			app = App.new [""]
			expect(system("ruby ./build/app.rb tests")).to eq true
		end
		describe 'tests option' do
			it 'should execute the google unit tests' do
				app = App.new ["test/failing_unit_test.rb"]
				expect(system("ruby ./build/app.rb tests")).to eq false

				app = App.new ["test/passing_unit_test.rb"]
				expect(system("ruby ./build/app.rb tests")).to eq true
			end
		end
	end
end
