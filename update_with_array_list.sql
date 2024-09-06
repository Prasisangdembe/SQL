CREATE OR REPLACE PROCEDURE update_with_array(
  schema_name TEXT,
  table_name TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
  schema_table TEXT := schema_name || '.' || table_name;
  log_table TEXT := schema_name || '.' || logtbl_name;
  category_array TEXT[][] := ARRAY[ 
    -- name                           last_name                                          age									                          city
     ARRAY['Prasis',                    'Angdembe',                                      '24',                                       'Birtamod'],
     ARRAY['Sumit',                     'Kumar',                                         '25',                                      'Biratnager'],
     ARRAY['Aashish',                   'Shah',                                          '23',                                       'Dhangadi'],
     
  ];
  query TEXT;
  BEGIN
    FOR i IN 1..array_length(category_array, 1) LOOP
      query := 'UPDATE ' || schema_table || ' SET name = $1, last_name = $2, age = $3 WHERE city = ANY($4::text[]) AND age IS NULL';
      EXECUTE query USING category_array[i][1], category_array[i][2], category_array[i][3], category_array[i][4]::text[];
    END LOOP;
  EXCEPTION
      RAISE;
END;
$$;
call update_with_array('SCHEMANAME','table_name');
drop procedure update_with_array;
