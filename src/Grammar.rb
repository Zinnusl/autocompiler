class Grammar
	def self.parse(file_path)
		rules = []

		grammar_file_content = File.read(file_path)

		grammar_file_content.scan(/`([^`]*)` -> `([^`]*)`/) do
			|matches|
			rules << {matches[0] => matches[1]}
		end

		rules
	end
end
