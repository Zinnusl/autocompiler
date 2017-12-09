require './src/Grammar'

describe Grammar do
	it 'should parse a grammer file' do
		rules = Grammar.parse 'ruby.grammar'

		expect(rules).to include({'' => '#requires_rule\n#main_rule\n'})
		expect(rules).to include({'#requires_rule' => ''})

		expect(rules.count).to satisfy {|v| v >= 3} 
	end
end
