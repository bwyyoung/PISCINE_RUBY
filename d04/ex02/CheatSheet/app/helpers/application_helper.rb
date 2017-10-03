# comment
module ApplicationHelper
  # comment
    def title(page_title)
    content_for :title, page_title.to_s
	end

	def log_book_reload
		history = []
		original_file = 'entry_log.txt'
		if File.exist?(original_file)
			File.foreach(original_file) do |li|
				history << li
			end
			@log_book = history;nil
		end
	end
end
