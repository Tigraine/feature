module Feature
  module Repository
    class FeatureFile
      def initialize(features)
        @features = (defined?(Rails) && features.has_key?(Rails.env)) ? features[Rails.env] : features
      end

      def valid?
        @features.is_a?(Hash) and @features.has_key?('features')
      end

      def generate_features_hash
        return {} unless @features['features']
        validate_feature_file_values
        @features['features']
      end

      def validate_feature_file_values
        invalid_value = @features['features'].values.detect { |value| ![true, false].include?(value) }
        raise ArgumentError, "#{invalid_value} is not allowed value in config, use true/false" if invalid_value
      end
      private :validate_feature_file_values
    end
  end
end
