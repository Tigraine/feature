module Feature
  module Repository
    class SimpleRepository
      def initialize
        @active_features = []
      end

      def active_features
        @active_features.dup
      end

      def add_active_feature(feature)
        check_feature_is_not_symbol(feature)
        check_feature_already_in_list(feature)
        @active_features << feature
      end

      def check_feature_is_not_symbol(feature)
        if !feature.is_a?(Symbol)
          raise ArgumentError, "given feature #{feature} is not a symbol"
        end
      end
      private :check_feature_is_not_symbol

      def check_feature_already_in_list(feature)
        if @active_features.include?(feature)
          raise ArgumentError, "feature :#{feature} already added to list of active features"
        end
      end
      private :check_feature_already_in_list
    end
  end
end
