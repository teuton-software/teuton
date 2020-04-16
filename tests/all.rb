#!/usr/bin/env ruby

require 'minitest/autorun'

require_relative 'application_test'
require_relative 'case_manager/case/case_test'
require_relative 'case_manager/case/config_test'
require_relative 'case_manager/case/result/result_test'
require_relative 'project/readme/readme_test'
require_relative 'project/configfile_reader_test'
require_relative 'project/name_file_finder_test'
# require_relative 'rubocop_test' # Duration: 60 seg. Require rubocop
require_relative 'teuton_test'
