require "spec_helper"

describe RailsEnvLocal do

  class EnvironmentParrot
    def what_it_is?
      (ENV["RAILS_ENV"] || ENV["RACK_ENV"] || Rails.env).dup
    end
  end

  before do
    Rails.env = "development"
    ENV["RAILS_ENV"] = nil
    ENV["RACK_ENV"] = nil
  end

  it "has a version number" do
    expect(RailsEnvLocal::VERSION).not_to be nil
  end

  context "vanilla" do
    let(:instance) { EnvironmentParrot.new }
    it "is not affected by RailsEnvLocal" do
      expect(instance.what_it_is?).to eq("development")
    end
    context "overrides" do
      context "RAILS_ENV" do
        before do
          ENV["RAILS_ENV"] = "soda"
        end
        it "works" do
          expect(instance.what_it_is?).to eq("soda")
        end
      end
      context "RACK_ENV" do
        before do
          ENV["RACK_ENV"] = "pop"
        end
        it "works" do
          expect(instance.what_it_is?).to eq("pop")
        end
      end
    end
  end

  context "defaults" do
    let(:instance) { EnvironmentParrot.new }
    before do
      ENV["RAILS_ENV"] = "watermelon"
      ENV["RACK_ENV"] = "papaya"
      RailsEnvLocal.set_local_environment
    end
    it "is affected by RailsEnvLocal" do
      expect(instance.what_it_is?).to eq("local")
    end
    context "overrides" do
      context "RAILS_ENV" do
        it "works" do
          expect(instance.what_it_is?).to eq("local")
        end
      end
      context "RACK_ENV" do
        it "works" do
          expect(instance.what_it_is?).to eq("local")
        end
      end
    end
  end

  context "options" do
    let(:instance) { EnvironmentParrot.new }
    before do
      ENV["RAILS_ENV"] = "watermelon"
      ENV["RACK_ENV"] = "papaya"
    end
    context "environment" do
      before do
        RailsEnvLocal.set_local_environment(environment: "temperate")
      end
      it "is affected by RailsEnvLocal" do
        expect(instance.what_it_is?).to eq("temperate")
      end
    end
    context "set_rails_env" do
      before do
        RailsEnvLocal.set_local_environment(environment: "malibu")
      end
      it "is affected by RailsEnvLocal" do
        expect(ENV["RAILS_ENV"]).to eq("malibu")
      end
    end
    context "set_rack_env" do
      before do
        RailsEnvLocal.set_local_environment(environment: "timbuktu")
      end
      it "is affected by RailsEnvLocal" do
        expect(ENV["RACK_ENV"]).to eq("timbuktu")
      end
    end
  end

end
