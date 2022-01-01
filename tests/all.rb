#!/usr/bin/env ruby

require 'minitest/autorun'

require_relative 'application_test'
require_relative 'case_manager/case/case_test'
require_relative 'case_manager/case/config_test'
require_relative 'case_manager/case/result/result_test'
require_relative 'utils/configfile_reader_test'
require_relative 'utils/name_file_finder_test'
# require_relative 'teuton_test'
# require_relative 'rubocop_test' # Duration: 60 seg. Require rubocop
