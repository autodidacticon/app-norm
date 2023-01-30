with norm as (
    select
        ROUND(app_sz_mb, -3) as app_sz_mb_1000,
        cat_norm
from {{ ref('app_store_data_norm') }}
where cat_norm in ('GAME', 'HEALTH', 'MUSIC')
)
select
    count(*) as bucket_count,
    app_sz_mb_1000,
    cat_norm

from norm

group by cat_norm, app_sz_mb_1000

order by cat_norm, app_sz_mb_1000
