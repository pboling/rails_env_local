require "spec_helper"

describe RailsEnvLocal do

  before do
    ENV["RAILS_ENV"] = nil
    ENV["RACK_ENV"] = nil
    Rails.remove_instance_variable(:@_env) if Rails.instance_variable_get(:@_env)
  end
  after do
    ENV["RAILS_ENV"] = nil
    ENV["RACK_ENV"] = nil
    Rails.remove_instance_variable(:@_env) if Rails.instance_variable_get(:@_env)
  end

  it "has a version number" do
    expect(RailsEnvLocal::VERSION).not_to be nil
  end

  context "vanilla" do
    before do
      Rails.env = "development"
      ENV["RAILS_ENV"] = nil
      ENV["RACK_ENV"] = nil
    end
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

  context "early shell overrides" do
    before do
      ENV["RAILS_ENV"] = "watermelon"
      ENV["RACK_ENV"] = "papaya"
      RailsEnvLocal.set_local_environment
    end
    it "take precedence" do
      expect(Rails.env).to eq("watermelon")
    end
    context "overrides" do
      context "RAILS_ENV" do
        it "works" do
          expect(ENV["RAILS_ENV"]).to eq("watermelon")
        end
      end
      context "RACK_ENV" do
        it "works" do
          expect(ENV["RACK_ENV"]).to eq("papaya")
        end
      end
    end
  end

  context "late shell overrides" do
    before do
      RailsEnvLocal.set_local_environment
      ENV["RAILS_ENV"] = "watermelon"
      ENV["RACK_ENV"] = "papaya"
    end
    it "is affected by RailsEnvLocal" do
      expect(Rails.env).to eq("localdev")
    end
    context "overrides" do
      context "RAILS_ENV" do
        it "works" do
          expect(ENV["RAILS_ENV"]).to eq("watermelon")
        end
      end
      context "RACK_ENV" do
        it "works" do
          expect(ENV["RACK_ENV"]).to eq("papaya")
        end
      end
    end
  end

  context "options" do
    context "environment" do
      before do
        RailsEnvLocal.set_local_environment(environment: "temperate")
      end
      it "is affected by RailsEnvLocal" do
        expect(Rails.env).to eq("temperate")
      end
    end
    context "set_rails_env" do
      context "default" do
        before do
          RailsEnvLocal.set_local_environment(environment: "malibu")
        end
        it "is affected by RailsEnvLocal" do
          expect(ENV["RAILS_ENV"]).to eq("malibu")
        end
      end
      context "true" do
        before do
          RailsEnvLocal.set_local_environment(environment: "malibu", set_rails_env: true)
        end
        it "is affected by RailsEnvLocal" do
          expect(ENV["RAILS_ENV"]).to eq("malibu")
        end
      end
      context "false" do
        before do
          RailsEnvLocal.set_local_environment(environment: "malibu", set_rails_env: false)
        end
        it "is affected by RailsEnvLocal" do
          expect(ENV["RAILS_ENV"]).to eq(nil)
        end
      end
    end
    context "set_rack_env" do
      context "default" do
        before do
          RailsEnvLocal.set_local_environment(environment: "malibu")
        end
        it "is affected by RailsEnvLocal" do
          expect(ENV["RACK_ENV"]).to eq("malibu")
        end
      end
      context "true" do
        before do
          RailsEnvLocal.set_local_environment(environment: "malibu", set_rack_env: true)
        end
        it "is affected by RailsEnvLocal" do
          expect(ENV["RACK_ENV"]).to eq("malibu")
        end
      end
      context "false" do
        before do
          RailsEnvLocal.set_local_environment(environment: "malibu", set_rack_env: false)
        end
        it "is affected by RailsEnvLocal" do
          expect(ENV["RACK_ENV"]).to eq(nil)
        end
      end
    end
    context "force" do
      before do
        RailsEnvLocal.set_local_environment(environment: "labrador", force: true)
      end
      context "RACK_ENV" do
        it "is affected by RailsEnvLocal" do
          expect(ENV["RACK_ENV"]).to eq("labrador")
        end
      end
      context "RAILS_ENV" do
        it "is affected by RailsEnvLocal" do
          expect(ENV["RAILS_ENV"]).to eq("labrador")
        end
      end
      context "Rails.env" do
        it "is affected by RailsEnvLocal" do
          expect(Rails.env).to eq("labrador")
        end
      end
    end
  end

end
