#!/usr/bin/ruby
# encoding: utf-8
	
class BaseFormatter
	def initialize(pReport)
		@head = pReport.head
		@lines = pReport.lines
		@tail = pReport.tail
	end
		
	def init(pFilename)
		@filename=pFilename
		@file = File.open(@filename,'w')
	end
	
	def w(pText)
		#write into output file
		@file.write pText.to_s
	end
		
	def process
		raise "Empty method!"
	end
		
	def deinit
		@file.close
	end
end
	
