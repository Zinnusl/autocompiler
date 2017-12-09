require './src/Grammar'

describe Grammar do
	it 'should parse a grammer file' do
		rules = Grammar.parse 'cpp.grammar'

		expect(rules).to include({'' => '//includes_rule\n//main_rule\n'})
		expect(rules).to include({'//includes_rule' => '#include<iostream>'})

		expect(rules.count).to satisfy {|v| v >= 3} 
	end
end
