require "spec_helper"

describe RailsEnvLocal do

  before do
    Rails.env = "development"
    ENV["RAILS_ENV"] = nil
    ENV["RACK_ENV"] = nil
  end

  it "has a version number" do
    expect(RailsEnvLocal::VERSION).not_to be nil
  end

  context "vanilla" do
    it "is not affected by RailsEnvLocal" do
      expect(Rails.env).to eq("development")
    end
    context "does not override" do
      context "RAILS_ENV" do
        before do
          ENV["RAILS_ENV"] = "soda"
        end
        it "works" do
          expect(ENV["RAILS_ENV"]).to eq("soda")
        end
      end
      context "RACK_ENV" do
        before do
          ENV["RACK_ENV"] = "pop"
        end
        it "works" do
          expect(ENV["RACK_ENV"]).to eq("pop")
        end
      end
    end
  end

  context "defaults" do
    before do
      ENV["RAILS_ENV"] = "watermelon"
      ENV["RACK_ENV"] = "papaya"
      RailsEnvLocal.set_local_environment
    end
    it "is affected by RailsEnvLocal" do
      expect(Rails.env).to eq("localdev")
    end
    context "overrides" do
      context "RAILS_ENV" do
        it "works" do
          expect(ENV["RAILS_ENV"]).to eq("localdev")
        end
      end
      context "RACK_ENV" do
        it "works" do
          expect(ENV["RACK_ENV"]).to eq("localdev")
        end
      end
    end
  end

  context "options" do
    before do
      ENV["RAILS_ENV"] = "watermelon"
      ENV["RACK_ENV"] = "papaya"
    end
    context "environment" do
      before do
        RailsEnvLocal.set_local_environment(environment: "temperate")
      end
      it "is affected by RailsEnvLocal" do
        expect(Rails.env).to eq("temperate")
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
