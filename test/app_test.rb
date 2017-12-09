require './src/App'

describe App do
	it 'should accept a list of cpp source files' do
		args = [ "a.cpp", "b.cpp", "c.cpp", "ruby.rb"]

		app = App.new args

		expect(app.test_files).to match_array(["a.cpp", "b.cpp", "c.cpp"])
	end
end
