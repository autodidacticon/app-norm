with apple_store as (
    select * from {{ ref('app_store_raw')}}
)

select
    `App_Name` as app_name,
    -- TODO: UDF for bytes to MB
    ROUND(`Size_Bytes` / 1048576) as app_sz_mb,
    `Size_Bytes` as app_sz_bytes,
    `Average_User_Rating` as avg_review_score,
    `Reviews` as review_count,
    DATE(`Released`) as release_date,
    -- TODO: udf for app store category normalization
    case
        when `Primary_Genre` in ('Games') then 'GAME'
        when `Primary_Genre` in ('Music') then 'MUSIC'
        when `Primary_Genre` in ('Health & Fitness') then 'HEALTH'
        else `Primary_Genre`
    end as cat_norm

from apple_store

where
`Primary_Genre` is not null
and `Size_Bytes` is not null