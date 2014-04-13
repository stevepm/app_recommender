Sequel.migration do
  up do
    create_table(:apps) do
      primary_key :id
      String :app_name, :null=> false, :unique=>true
      String :app_url
    end
  end
  down do
    drop_table(:apps)
  end
end