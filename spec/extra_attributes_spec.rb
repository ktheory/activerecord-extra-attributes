describe "ExtraAttributes", "mixin" do

  before(:all) do
    require 'tempfile'
    ActiveRecord::Base.establish_connection(
      :adapter => "sqlite3",
      :database  => Tempfile.new("extra_attributes").path
    )
    require 'migration.rb'
    CreateExtraAttributesTable.migrate(:up)
  end

  it "should cast values correctly" do
    ExtraAttribute.cast("1", :integer).should == 1
    ExtraAttribute.cast("foo", :string).should == "foo"
    ExtraAttribute.cast(123, :string).should == "123"

    # Test false boolean values
    [0,'0', 'false', 'False', 'FALSE', false].each do |val|
      ExtraAttribute.cast(val, :boolean).class.should == FalseClass
    end

    # Test true boolean values
    [1,"1", "true", "foo"].each do |val|
      ExtraAttribute.cast(val, :boolean).class.should == TrueClass
    end
  end

end
