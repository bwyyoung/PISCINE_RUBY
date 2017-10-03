class CheatController < ApplicationController
	@log_book
  def convention
  end
  def console
  end
  def ruby
  end
  def ruby_concepts
  end
  def ruby_numbers
  end
  def ruby_strings
  end
  def ruby_arrays
  end
  def ruby_hashes
  end
  def rails
  end
  def rails_folder_structure
  end
  def rails_commands
  end
  def rails_erb
  end
  def editor
  end
  def help
  end
  def quick_search
  end
  def log_book
	 if params[:log_field] && params[:log_field].length > 0
		 puts "logging data  " +  params[:log_field] + "  " + params[:log_field].length.to_s
		 original_file = 'entry_log.txt'
		 new_file = original_file + '.new'
		 d = DateTime.now
		 history = []
		 final_file = File.open(new_file, 'w') { |file|
			file.puts d.strftime("%d/%m/%Y %H:%M:%S  : ") + params[:log_field]
			history << d.strftime("%d/%m/%Y %H:%M:%S  : ") + params[:log_field]
			if File.exist?(original_file)
				File.foreach(original_file) do |li|
					file.puts li
					history << li
				end
			end
		 }
		 @log_book = history
		 if File.exist?(original_file)
			 File.rename(original_file, original_file + '.old')
		 end
		 File.rename(new_file, original_file)
		 if File.exist?(original_file + '.old')
			 File.delete(original_file + '.old')
		 end
		 redirect_to :log_book
	 end
  end


end
