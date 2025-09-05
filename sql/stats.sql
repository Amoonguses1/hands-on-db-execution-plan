SELECT
    schemaname,
    tablename,
    attname,
    null_frac,
    n_distinct
FROM
    pg_stats
WHERE
    tablename IN ('customers', 'orders');
