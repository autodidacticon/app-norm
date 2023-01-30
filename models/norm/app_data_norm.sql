with play_store as (
    select * from {{ ref('play_store_data_norm')}}
        where cat_norm in ('GAME', 'HEALTH', 'MUSIC')
), apple_store as (
    select * from {{ ref('app_store_data_norm')}}
    where cat_norm in ('GAME', 'HEALTH', 'MUSIC')
)

select
    app_name,
    app_sz_mb,
    app_sz_bytes,
    avg_review_score,
    review_count,
    release_date,
    cat_norm
from play_store
union all
select
    app_name,
    app_sz_mb,
    app_sz_bytes,
    avg_review_score,
    review_count,
    release_date,
    cat_norm
from apple_store
