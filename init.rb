$:.unshift('lib')

require 'rubygems'
require 'active_record'
require 'extra_attribute'
require 'extra_attributes'
ActiveRecord::Base.send(:include, Zenbe::ExtraAttributes)
