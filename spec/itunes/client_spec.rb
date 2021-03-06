require 'spec_helper'

describe ITunes::Client do

  use_vcr_cassette :record => :new_episodes, :match_requests_on => [:uri, :method]

  describe ".lookup" do
    before(:each) do
      @client = ITunes::Client.new
    end

    it "should return results for valid ids" do
      item = @client.lookup('396405320')
      item.results.first.collection_name.should == 'Hold it Down - Single'
      item.results.first.primary_genre_name == 'Dance'
    end

    describe "when using amg ids" do
      describe "artist ids" do
        it "should return a valid item when passed a single id" do
          items = @client.lookup('468749', :id_type => :amg_artist)
          items.result_count.should == 2
        end

        it "should return a results when passed a comma separated string of ids" do
          items = @client.lookup('468749,5723', :id_type => :amg_artist)
          items.result_count.should == 3
        end

        it "should return results when passed an array of ids" do
          items = @client.lookup(['468749','5723'], :id_type => :amg_artist)
          items.result_count.should == 3
        end
      end


      describe "album ids" do
        it "should return a valid item when passed a single id" do
          items = @client.lookup('15197', :id_type => :amg_album)
          items.results.first.artist_name.should == 'Wilson Pickett'
        end

        it "should return a results when passed a comma separated string of ids" do
          items = @client.lookup('15197,15198', :id_type => :amg_album)
          items.results.first.artist_name.should == 'Wilson Pickett'
        end

        it "should return results when passed an array of ids" do
          items = @client.lookup(['15197','15198'], :id_type => :amg_album)
          items.results.first.artist_name.should == 'Wilson Pickett'
        end
      end
    end

    describe "when using a upc id" do
      it "should return a valid item when passed a single id" do
        items = @client.lookup('075678317729', :id_type => :upc)
      end
    end

    describe "when passing an id_type other than amg or upc" do
      it "should raise an error" do
        lambda {
          @client.lookup('1235', :id_type => :lastfm)
        }.should raise_error
      end
    end
  end

  describe "search" do
    before(:each) do
      @client = ITunes::Client.new
    end

    describe ".all" do
      it "should raise an ArgumentError when passed a nil search term" do
        lambda {
          @client.all(nil)
        }.should raise_error
      end

      it "should raise an ArgumentError when passed an empty string as a search term" do
        lambda {
          @client.all('')
        }.should raise_error
      end

      it "should accept a limit option" do
        response = @client.all('Michael Jackson', :limit => 2)
        response.result_count.should == 2
      end

      it "should ignore the limit when set to 0" do
        @client.limit = 0
        response = @client.all('Michael Jackson')
        response.result_count.should > 0
      end
    end

    describe ".music" do
      it "should return music results" do
        response = @client.music('Jose James')
        response.results.each do |result|
          result.kind.should == 'song'
        end
      end
    end

    describe ".podcast" do
      it "should return podcast results" do
        response = @client.podcast('Beyondjazz')
        response.results.each do |result|
          result.kind.should == 'podcast'
        end
      end
    end

    describe ".movie" do
      it "should return movie results" do
        response = @client.movie('Blade Runner')
        response.results.each do |result|
          result.kind.should == 'feature-movie'
        end
      end
    end

    describe ".music_video" do
      it "should return music video results" do
        response = @client.music_video('Sabotage')
        response.results.each do |result|
          result.kind.should == 'music-video'
        end
      end
    end

    describe ".audiobook" do
      it "should return audiobook results" do
        response = @client.audiobook('Ernest Hemingway')
        response.results.each do |result|
          result.wrapper_type.should == 'audiobook'
        end
      end
    end

    describe ".short_film" do
      it "should return short film results" do
        response = @client.short_film('Pixar')
        response.results.each do |result|
          result.kind.should == 'feature-movie'
        end
      end
    end

    describe ".tv_show" do
      it "should return tv show results" do
        response = @client.tv_show('Lost')
        response.results.each do |result|
          result.kind.should == 'tv-episode'
        end
      end
    end
  end

end