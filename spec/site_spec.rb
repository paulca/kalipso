require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Kalipso::Site do

  describe Kalipso::Site::Remote do
    describe ".all" do
      use_vcr_cassette "kalipso/all_empty", :record => :new_episodes
      subject { Kalipso::Site::Remote.all }
      
      it { should be_empty }
    end
    
    describe ".find" do
      use_vcr_cassette "kalipso/find", :record => :new_episodes
      subject { Kalipso::Site::Remote.find(44) }
      
      it { should_not be_nil }
      its(:name) { should == 'testsite' }
    end
    
    describe "#save" do
      use_vcr_cassette "kalipso/save_and_all", :record => :new_episodes
      subject { Kalipso::Site::Remote.new(:name => "automatedtest") }
      
      before do
        subject.save
      end
      
      its(:id) { should_not be_nil }
    end
    
    describe "#update_attributes" do
      use_vcr_cassette "kalipso/update", :record => :new_episodes
      let(:site) { Kalipso::Site::Remote.find(46) }
      subject { site.update_attributes(:name => 'somethingelse') }
      its(:name) { should == 'somethingelse' }
    end
    
    describe "#delete" do
      use_vcr_cassette "kalipso/create_and_delete", :record => :new_episodes
      subject { Kalipso::Site::Remote.all }
      
      before do
        site = Kalipso::Site::Remote.new(:name => "tobedeleted")
        site.save
        site.destroy
      end
      
      it { should be_empty }
    end
  end
  
end