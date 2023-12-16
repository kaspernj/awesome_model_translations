module AwesomeModelTranslations::CurrentTranslationScope
  def self.included(base)
    translation_class_name = "#{base.name}::Translation"
    translation_class = translation_class_name.constantize
    table_name = translation_class.table_name
    foreign_key_name = base.reflections["translations"].foreign_key

    scope_proc = proc do
      locales_list = I18n.available_locales.join("', '")
      sub_query_sql = "#{table_name}.#{translation_class.primary_key} = (" \
        "SELECT #{table_name}.#{translation_class.primary_key} " \
        "FROM #{table_name} " \
        "WHERE #{table_name}.#{foreign_key_name} = #{base.table_name}.#{base.primary_key} AND " \
          "#{table_name}.locale IN ('#{locales_list}') " \
        "ORDER BY " \
        "CASE WHEN #{table_name}.locale = '#{I18n.locale}' THEN 1 " \
        "ELSE 2 " \
        "END " \
        "LIMIT 1" \
        ")"

      where(sub_query_sql)
    end

    base.has_one :current_translation, scope_proc, class_name: translation_class_name
  end
end
