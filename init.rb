$:.unshift('lib')

require 'active_record'
require 'extra_attribute'
require 'extra_attributes'
ActiveRecord::Base.send(:include, KTheory::ExtraAttributes)
