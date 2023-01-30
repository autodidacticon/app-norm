with play_store as (
    select * from {{ ref('play_store_raw')}}
)

select
    `App Name` as app_name,
    -- TODO: UDF for `Size` abbrev string to MB
    case
        when `Size` like '%k' then ROUND(REPLACE(`Size`, 'k', '') * 1024 / 1048576)
        when `Size` like '%M' then ROUND(REPLACE(`Size`, 'M', ''))
    end as app_sz_mb,
    case
        when `Size` like '%k' then ROUND(REPLACE(`Size`, 'k', '') * 1024)
        when `Size` like '%M' then ROUND(REPLACE(`Size`, 'M', '') * 1048576)
    end as app_sz_bytes,
    `Rating` as avg_review_score,
    `Rating Count` as review_count,
    to_date(`Released`, 'MMM d, yyyy') as release_date,
    -- TODO: udf for play store `Category` normalization
    case
        when `Category` in ('Action', 'Adventure', 'Arcade', 'Board', 'Card', 'Casino', 'Casual', 'Educational', 'Music',
        'Puzzle', 'Racing', 'RolePlaying', 'Simulation', 'Sports', 'Strategy', 'Trivia', 'Word')
        then 'GAME'
        when `Category` in ('Music & Audio') then 'MUSIC'
        when `Category` in ('Health & Fitness') then 'HEALTH'
        else `Category`
    end as cat_norm

from play_store

where
`Size` is not null
and `Category` is not null
