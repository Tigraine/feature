require 'spec_helper'

include Feature::Repository

describe Feature::Repository::FeatureFile do
  describe "valid?" do
    it "should return false if features is not a hash" do
      feature_file = FeatureFile.new("")
      feature_file.valid?.should be_false
    end

    it "should return false if the features hash does not have a key called 'features'" do
      features_file = FeatureFile.new({'fatures' => false})
      features_file.valid?.should be_false
    end

    it "should return true if the features hash does have a key called 'features'" do
      features_file = FeatureFile.new({'features' => true})
      features_file.valid?.should be_true
    end
  end

  describe "generate_features_hash" do
    it "should return an empty hash if 'features' is nil" do
      features_file = FeatureFile.new({'features' => nil})
      features_file.generate_features_hash.should eql({})
    end

    it "should raise an exception if there is a value against a feature that is not true or false" do
      features_file = FeatureFile.new({'features' => {'f1' => true, 'f2' => false, 'f3' => 'wrong'}})
      lambda { features_file.generate_features_hash }.should raise_error(ArgumentError, "wrong is not allowed value in config, use true/false")
    end

    it "should return a hash of all features if all their values are valid" do
      features_file = FeatureFile.new({'features' => {'f1' => true, 'f2' => false, 'f3' => true}})
      features_file.generate_features_hash.should eql({'f1' => true, 'f2' => false, 'f3' => true})
    end
  end
end
