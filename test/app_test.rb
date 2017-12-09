require './src/App'

describe App do
	it 'should create a executable (.exe)' do
		file = double('file')
		expect(File).to receive(:open).with("build/out.exe", "w").and_yield(file)
		expect(file).to receive(:write).with("test")

		app = App.new [""]
	end
	it 'should accept a list of cpp source files' do
		args = [ "a.cpp", "b.cpp", "c.cpp", "ruby.rb"]

		app = App.new args

		expect(app.test_files).to match_array(["a.cpp", "b.cpp", "c.cpp"])
	end
end
