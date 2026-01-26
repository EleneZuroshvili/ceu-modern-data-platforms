{{ config(
  materialized = 'table',
) }}
WITH
f AS (
    SELECT
        *
    FROM
        {{ ref('fct_reviews') }}
),
s AS (
    SELECT *
    FROM {{ ref('seed_full_moon_dates') }}
)
SELECT
    f.*,
  CASE
    WHEN s.full_moon_date IS NULL THEN 'not full moon'
    ELSE 'full moon'
  END AS is_full_moon
FROM f
LEFT JOIN s ON (TO_DATE(f.review_date) = DATEADD(DAY, 1, s.full_moon_date))