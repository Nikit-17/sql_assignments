CREATE OR REPLACE FUNCTION fn_title_case_city(p_city TEXT)
RETURNS TEXT AS $$
BEGIN
    RETURN initcap(p_city);
END;
$$ LANGUAGE plpgsql;
SELECT fn_title_case_city('biratnagar city');
