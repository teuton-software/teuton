#!/usr/bin/ruby
# encoding: utf-8

module Builder

	def build_game_list(pArgs={})
		# build directories
		ensure_dir File.join(@outdir, "public")		
		ensure_dir File.join(@outdir, "views")

		# build script show_gamelist.rb
		filename=File.join(@outdir, "show_gamelist.rb")
		file = File.open( filename, 'w' )
		file.write("#!/usr/bin/ruby\n# encoding: utf-8\n\nrequire 'sinatra/base'\n\n")
		file.write("class GameList < Sinatra::Base\n")
  
        file.write("  set :static, true\n")
        file.write("  set :public_folder, 'public'\n")

		file.write("  set :bind, '#{pArgs[:ip].to_s}'\n") if !pArgs[:ip].nil? 
		file.write("  set :port, '#{pArgs[:port].to_s}'\n") if !pArgs[:port].nil? 

		file.write("  get '/' do\n    erb :index\n  end\n")
		file.write("end\n\n")
		file.write("GameList.run!\n")

		file.close
		File.chmod(0775, filename)
		
		#build views/index.erb
		filename=File.join(@outdir, "views", "index.erb")
		file = File.open( filename, 'w' )
		file.write("<h1>GameList: #{@global[:tt_testname]}</h1>")
		file.write("<p>Date: #{Time.now.to_s}</p><hr>")
		file.write("<table border='1'>")
		file.write("<thead><tr><td>NRO</td><td>Case</td><td>Grade</td><td>History</td></tr></thead>")
		file.write("<tbody>")
		list=[]
		@cases.each do |c|
			name=c.report.head[:tt_members] || 'noname'
			list << [ c.report.tail[:grade].to_f, name.to_s, c.report.history.to_s ]
		end
		list.each_with_index { |i,index| file.write("<tr><td>#{index}</td><td>#{i[1]}</td><td>#{i[0]}</td><td>#{i[2]}</td></tr>") }
		file.write("</tbody></table>")
		file.close
	end
	
end

