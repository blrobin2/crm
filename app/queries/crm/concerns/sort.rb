module Crm
  module Concerns
    module Sort
      # rubocop:disable Metrics/MethodLength
      def sort_conditions
        return default_sort unless params[:sort]

        params[:sort].split(',').map do |sort_field|
          field = sort_field.delete('-')
          direction = sort_direction(sort_field)
          Arel.sql(
            if field.include?('.')
              multiple_sort(field, direction)
            elsif jsonb_field?(field)
              jsonb_sort(field, direction)
            else
              usual_sort(field, direction)
            end
          )
        end
      end
      # rubocop:enable Metrics/MethodLength

      def mulitiple_sort(field, direction)
        relationship_name, relationship_attribute = field.split('.')
        field = relationship_tablew_name(relationship_name)
        "#{field}.#{relationship_attribute} #{direction} #{nils_last}"
      end

      def jsonb_sort(field, direction)
        "UPPER(#{field}->>'#{I18n.locale}') COLLATE \"C\" #{direction} #{nils_last}"
      end

      def usual_sort(field, direction)
        if textual_field?(field)
          "UPPER(#{field}) COLLATE \"C\" #{direction} #{nils_last}"
        else
          "#{field} #{direction} #{nils_last}"
        end
      end

      def relationship_table_name(relationship_name)
        sort_relationship_mappings.first.find do |mapping|
          mapping.first == relationship_name.to_sym
        end.last
      end

      def sort_direction(sort_field)
        sort_field.starts_with?('-') ? 'DESC' : 'ASC'
      end

      def jsonb_field?(name)
        column_type(name) == :jsonb
      end

      def textual_field?(name)
        column_type(name).in?([:string, :text])
      end

      def column_type(name)
        model.column_for_attributes(name).type
      end

      def nils_last
        'NULLS LAST'
      end

      def model
        self.class.name.demodulize.split('Query').first.singularize.constantize
      end
    end
  end
end
