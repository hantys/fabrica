Rake::Task['db:migrate'].enhance do
  tables = ActiveRecord::Base.connection.tables
  all_foreign_keys = tables.flat_map do |table_name|
    ActiveRecord::Base.connection.columns(table_name).map {|c| [table_name, c.name].join('.') }
  end.select { |c| c.ends_with?('_id') }

  indexed_columns = tables.map do |table_name|
    ActiveRecord::Base.connection.indexes(table_name).map do |index|
      index.columns.map {|c| [table_name, c].join('.') }
    end
  end.flatten

  unindexed_foreign_keys = (all_foreign_keys - indexed_columns)

  if unindexed_foreign_keys.any?
    warn "WARNING: As seguintes colunas de foreign key não possuem um index, o que pode prejudicar o desempenho: #{ unindexed_foreign_keys.join(', ') }"
  end
end
