module Feature
  module Repository
    class YamlRepository
      require 'erb'
      require 'yaml'

      def initialize(yaml_file_name)
        @yaml_file_name = yaml_file_name
      end

      def active_features
        features_hash = read_and_parse_features_yaml_file
        features = features_hash.keys.select { |feature_key| features_hash[feature_key] }
        features.sort.map(&:to_sym)
      end

      def read_and_parse_features_yaml_file
        feature_file = FeatureFile.new(YAML::load(ERB.new((IO.read(@yaml_file_name))).result))
        raise ArgumentError, "content of #{@yaml_file_name} does not contain proper config" if !feature_file.valid?
        feature_file.generate_features_hash
      end
      private :read_and_parse_features_yaml_file
    end
  end
end
