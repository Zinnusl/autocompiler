require './src/Grammar'

describe Grammar do
	it 'should parse a grammer file' do
		rules = Grammar.parse 'cpp.grammar'

		expect(rules).to include({'' => '//includes_rule\n//main_rule\n'})
		expect(rules).to include({'//includes_rule' => '#include<iostream>'})
		expect(rules).to include({'//main_rule' => 'int main(int argc, char** argv)\n{\n}'})
	end
end
