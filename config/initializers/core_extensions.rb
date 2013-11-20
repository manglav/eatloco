class ActiveRecord::Base

  def self.exclude(attribute, arr)
    where(arr.any? ? "#{attribute} NOT IN (#{arr.join(',')})" : "#{attribute} IS NOT NULL")
  end

  def self.where_not(opts)
    params = []
    sql = opts.map{|k, v| params << v; "#{quoted_table_name}.#{quote_column_name k} != ?"}.join(' AND ')
    where(sql, *params)
  end

end
