require "test_helper"

describe DecodeResults do

  describe "It loads a new file for the first time" do
    before do
      @race = Race.create(name: 'test')
      DecodeResults.new.call(@race, File.new("#{Rails.root}/test/fixtures/results.csv"))
      @runner = @race.results.where(name: 'Adeline Leydet').first
    end
    it "loads all the rows" do
      @race.results.count.must_equal 10
    end
    it "loads all the name" do
      @runner.country.must_equal 'FRA'
    end
    it "loads all the phone" do
      @runner.phone.must_equal '33682568000'
    end
    it "loads all the mail" do
      @runner.mail.must_equal 'adeline.leydet@example.com'
    end
    it "loads all the rank" do
      @runner.rank.must_equal 145
    end
    it "loads all the bib" do
      @runner.bib.must_equal '2'
    end
    it "loads all the categ_rank" do
      @runner.categ_rank.must_equal 23
    end
    it "loads all the categ" do
      @runner.categ.must_equal 'SE'
    end
    it "loads all the sex" do
      @runner.sex.must_equal 'F'
    end
    it "loads all the sex_rank" do
      @runner.sex_rank.must_equal 38
    end
    it "loads all the time" do
      @runner.time.must_equal '01:29:44'
    end
    it "loads all the speed" do
      @runner.speed.must_equal '8,02'
    end
    it "loads all the message" do
      @runner.message.must_equal nil
    end
    it "loads all the race_detail" do
      @runner.race_detail.must_equal "12"
    end
    it "sets uploaded_at" do
      @runner.uploaded_at.wont_be_nil
    end
  end

  describe "It loads a twice the same file" do
    it "it loads all the rows" do
      race = Race.create(name: 'test')
      DecodeResults.new.call(race, File.new("#{Rails.root}/test/fixtures/results.csv"))
      DecodeResults.new.call(race, File.new("#{Rails.root}/test/fixtures/results.csv"))
      race.results.count.must_equal 10
    end
  end

  describe "It loads a file with new rows and updated data" do
    before do

      @race = Race.create(name: 'test')
      DecodeResults.new.call(@race, File.new("#{Rails.root}/test/fixtures/results.csv"))
      @adeline_before_update = @race.results.where(name: 'Adeline Leydet').first
      @adrien_before_update = @race.results.where(name: 'Adrien Peigne').first
      Timecop.travel(@adrien_before_update.updated_at + 5.minutes)
      DecodeResults.new.call(@race, File.new("#{Rails.root}/test/fixtures/results_updated_and_new_times.csv"))
    end
    it "loads all the rows" do
      @race.results.count.must_equal 11
    end
    it "updates times for Adeline" do
      @adeline = @race.results.where(name: 'Adeline Leydet').first
      @adeline.time.wont_equal @adeline_before_update.time
    end
    it "updates uploaded_at for adeline" do
      @adeline = @race.results.where(name: 'Adeline Leydet').first
      @adeline.time.wont_equal @adeline_before_update.time
    end
    it "doesn't change uploaded_at for adrien" do
      @adrien = @race.results.where(name: 'Adrien Peigne').first
      @adrien.uploaded_at.must_equal @adrien_before_update.uploaded_at
    end

  end

end
